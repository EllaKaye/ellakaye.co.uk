library(tidyverse)

customers <- read_csv(here::here("5784", "data", "noahs-customers.csv"))
orders_items <- read_csv(here::here("5784", "data", "noahs-orders_items.csv"))
orders <- read_csv(here::here("5784", "data", "noahs-orders.csv"))
products <- read_csv(here::here("5784", "data", "noahs-products.csv"))

# Clues:
# Moved house - maybe two addresses in the database?
# Wood floors in new house - is there a wood floor cleaning product?
# Frugal: coupons and shows in the sale at Noah's Market
# Noah loses money. Maybe a difference between wholesale and sale price?
# Lives a subway ride away from the Cat Lady. Addresses may be relevant.
# Slow to respond to texts. Not sure what that might relate to in the data though.

# someone with two addresses
customers |> 
	add_count(customerid) |> 
	filter(n > 1) |> 
	arrange(name)
# no one has two address

# Wood cleaner?
products |> 
	#filter(str_detect(desc, "Wood")) |> 
	filter(str_detect(desc, "Floor"))

# Noah loses money.
# There's a wholesale_cost in 'products' and a unit_price and qty in order_item
# both have 'sku' to join on.
# What orders did Noah lose money on?
wholesale_gt_shop <- left_join(orders_items, products, by = "sku") |> 
	mutate(shop_price = qty * unit_price,
				 wholesale_price = qty * wholesale_cost) |> 
	select(-sku, -unit_price, -desc, -wholesale_cost, -dims_cm) |> 
	summarise(order_shop_price = sum(shop_price),
						order_wholesale_price = sum(wholesale_price),
						.by = orderid) |> 
	filter(order_wholesale_price > order_shop_price)

# Join with customers. 
# Perhaps there's someone for whom this happens repeatedly.

left_join(wholesale_gt_shop, orders, by = "orderid") |> 
	select(orderid:customerid) |> 
	count(customerid, sort = TRUE) |> 
# This is the case for one customer in particular: 4167	
	slice_max(n) |> 
	pull(customerid)

customers |> 
	filter(customerid == 4167) |> 
	pull(phone)
# let's try submitting that. Correct!
# 585-838-9161