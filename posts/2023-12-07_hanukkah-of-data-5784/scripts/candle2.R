customers <- read_csv(here::here("5784", "data", "noahs-customers.csv"))
orders_items <- read_csv(here::here("5784", "data", "noahs-orders_items.csv"))
orders <- read_csv(here::here("5784", "data", "noahs-orders.csv"))
products <- read_csv(here::here("5784", "data", "noahs-products.csv"))

# The claim ticket said ‘2017 JP’. 
# ‘2017’ is the year the item was brought in, 
# and ‘JP’ is the initials of the contractor.
# Find their contact details.

# First, lets look for initials JP in customers
JP_customers <- customers |> 
#	select(name, phone, customerid) |> 
	separate_wider_delim(name, delim = " ", 
											 names = c("first", "last"), 
											 too_many = "merge") |> 
	mutate(first_initial = str_extract(first, ".")) |> 
	mutate(last_initial = str_extract(last, ".")) |> 
	filter(first_initial == "J") |> 
	filter(last_initial == "P") |> 
	select(-first_initial, -last_initial)
# There are 61 JP customers.

colnames(customers)
# We're going to need to find something we can use with dates
# to take advantage of knowing the ticket is 2017,
# and that they haven't used contractors in a while
glimpse(orders)
glimpse(orders_items)
glimpse(products)
glimpse(customers)

# "orders" looks promising.
# There's 'customerid' that we can join with `JP_customers`
# and "ordered", which gives dates of orders
ordered <- orders |> 
	select(customerid, ordered) |> 
	mutate(ordered_year = str_extract(ordered, ".{4}"))

JP_ordered <- left_join(JP_customers, ordered, by = "customerid") |> 
	select(-ordered) |> 
	distinct()

# Not sure where to go from here.
# Maybe the key piece of information is that the contractors are across the street from Noah's.
# At least I think so - not clear if it's the cleaners or contractors that are close.
# So maybe there's something in the location details of "customers" that's useful
JP_customers
# Do we know where Noah's is? No
# The contractors would buy coffee and bagels and cleaning supplies
# So we may need to look in orders_items
JP_customers
orders_items
# then we'll need to look at products to match sku
products

# let's start by filtering orders on JP customers
order_desc <- orders |> 
	filter(customerid %in% JP_customers$customerid) |> 
	left_join(orders_items, by = "orderid") |> 
	left_join(products, by = "sku") |> 
	#select(customerid, orderid, desc) |> 
	#filter(str_detect(desc, "[Bb]agel")) |> 
	#filter(str_detect(desc, "[Cc]offee")) |> 
	I()

# By inspection, customer ID 1475 is the only one to have ordered both coffee and bagel
customers |> 
	filter(customerid == 1475) |> 
	pull(phone)

# That's correct, so let's do it properly
contractor <- order_desc |> 
	group_by(customerid, orderid) |> 
	mutate(full_order = paste(desc, collapse = " ")) |> # trick learnt from David Robinson in Day 3 of Advent of Code!
	filter(str_detect(full_order, "Coffee") & str_detect(full_order, "Bagel")) |> 
	distinct(customerid) |> 
	pull(customerid)

customers |> 
	filter(customerid == contractor) |> 
	pull(phone)
# This is it! 332-274-4185

# Now improve:
JP_customers <- customers |> 
	separate_wider_delim(name, delim = " ", 
											 names = c("first", "last"), 
											 too_many = "merge") |> 
	filter(str_detect(first, "^J")) |> 
	filter(str_detect(last, "^P")) 

order_desc <- orders |> 
	filter(customerid %in% JP_customers$customerid) |> 
	left_join(orders_items, by = "orderid") |> 
	left_join(products, by = "sku") |> 
	select(customerid, orderid, desc) 
# maybe should account for year in here too. 
# We know it's 2017, so can use either `ordered` or `shipped` to get that

contractor <- order_desc |> 
	group_by(customerid, orderid) |> 
	filter(any(str_detect(desc, "Coffee")) & any(str_detect(desc, "Bagel"))) |> 
	distinct(customerid) |> 
	pull(customerid)	

customers |> 
	filter(customerid == contractor) |> 
	pull(phone)
# This is it! 332-274-4185