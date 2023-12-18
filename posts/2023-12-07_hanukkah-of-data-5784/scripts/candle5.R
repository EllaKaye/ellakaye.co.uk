library(tidyverse)

customers <- read_csv(here::here("5784", "data", "noahs-customers.csv"))
orders_items <- read_csv(here::here("5784", "data", "noahs-orders_items.csv"))
orders <- read_csv(here::here("5784", "data", "noahs-orders.csv"))
products <- read_csv(here::here("5784", "data", "noahs-products.csv"))

# woman who lives on Staten Island,
# has a Noah's Market sweatshirt and lots of old cats.

SI_customers <- customers |> 
	filter(str_detect(citystatezip, "Staten"))

products |> 
	#filter(str_detect(desc, "Sweatshirt")) |> # nothing
	filter(str_detect(desc, "Noah's")) |> 
	arrange(desc) |> 
	View()
# looks like we want strings containing "Noah's Jersey"


products |> 
	filter(str_detect(desc, "Cat"))

# find products bought by SI_customers
cat_jersey_ids <- SI_customers |> 
	left_join(orders, by = "customerid") |> 
	left_join(orders_items, by = "orderid") |> 
	left_join(products, by = "sku") |> 
	filter(str_detect(desc, "Noah's Jersey") |
				 	str_detect(desc, "Senior Cat")) |> 
	select(customerid, name, phone, desc) |> 
	distinct() |> 
	mutate(jersey = str_detect(desc, "Jersey")) |> 
	mutate(cat = str_detect(desc, "Cat")) |> 
	select(-desc) |> 
	distinct() |> 
	count(customerid) |> 
#	count(name) |> 
	filter(n > 1) |> # 8 possibilities, including more two women, IDs 1980 and 4795
	pull(customerid)

cat_jersey <- SI_customers |> 
	left_join(orders, by = "customerid") |> 
	left_join(orders_items, by = "orderid") |> 
	left_join(products, by = "sku") |> 
	filter(str_detect(desc, "Noah's Jersey") |
				 	str_detect(desc, "Senior Cat")) |> 
	select(customerid, name, phone, desc) |> 
	distinct() |> 
	mutate(jersey = str_detect(desc, "Jersey")) |> 
	mutate(cat = str_detect(desc, "Cat")) |> 
	filter(customerid %in% cat_jersey_ids)

cat_jersey |> View()

customers |> 
	filter(customerid %in% c(1980, 4795))

# try both as answers, and work backwards as needed
# Hmmm, neither of those are right. Also tried number for Alex Moore, also not right.

# Maybe it's not senior cat food, maybe its lots of cat food?
products |> 
	filter(str_detect(desc, "Cat Food")) |> 
	#	filter(str_detect(desc, "Kitten")) |> # none for Kitten
	arrange(desc) |> 
	View()

# lets get jerseys first
SI_customers |> 
	left_join(orders, by = "customerid") |> 
	left_join(orders_items, by = "orderid") |> 
	left_join(products, by = "sku") |> 
	filter(str_detect(desc, "Noah's Jersey")) #|> 
	#filter(str_detect(name, "Eliz")) #|> 
#	pull(phone)
# manually tried Elizabeth Gray (the) only woman not found before, also not right.

# Jersey not getting me anywhere. Let's focus on lots of cats.
most_cat_food <- SI_customers |> 
	left_join(orders, by = "customerid") |> 
	left_join(orders_items, by = "orderid") |> 
	left_join(products, by = "sku") |> 
	filter(str_detect(desc, "Cat Food")) |>  #View()
	select(customerid, name, phone, qty) |> 
	summarise(qty_cat_food = sum(qty), .by = customerid) |> 
	slice_max(qty_cat_food) |> 
	pull(customerid)

customers |> 
	filter(customerid == most_cat_food) |> 
	pull(phone)

# OK, but bothering me that she hasn't bought a jersey.
# Perhaps someone at her address has?

customers |> 
	filter(customerid == most_cat_food) |> 
	pull(address)

customers |> 
	filter(address == "208 Ramapo Ave")

# Find everything that she's ordered

orders |> 
	filter(customerid == most_cat_food) |> 
	left_join(orders_items) |> 
	left_join(products) |> View()
# She has bought lots of Senior Cat Food, but no Jersey.