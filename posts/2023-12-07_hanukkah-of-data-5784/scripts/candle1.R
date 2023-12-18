library(tidyverse)
customers <- read_csv(here::here("5784", "data", "noahs-customers.csv"))
View(customers)

glimpse(customers)

# all customers have a phone number
customers |> 
	summarise(sum(is.na(phone)))

# all phone numbers are 12 chars 
# by inspection, ddd-ddd-dddd (10 digits)
customers |> 
	mutate(phone_length = nchar(phone)) |> 
	count(phone_length)

# split name into cols, hopefully only one will be 10 chars!
customers |> 
	select(name, phone) |> 
	separate_wider_delim(name, delim = " ", names = c("first", "last"))
# 725 too many

# tricky, because of cases of names with two " "
customers |> 
	select(name, phone) |> 
	mutate(jr = str_detect(name, "Jr.")) |> 
	summarise(sum(jr))

# use too_many = "merge", splits on first delim
cs <- customers |> 
	select(name, phone) |> 
	separate_wider_delim(name, delim = " ", 
											 names = c("first", "last"), 
											 too_many = "merge")

# now what's happened with last names? Still in two parts?
cs |> 
	mutate(split_last = str_detect(last, "\\s")) |> 
	summarise(sum(split_last))

# This works to split name into three cols
cs |> 
	separate_wider_delim(last, delim = " ", 
											 names = c("last", "suffix"), 
											 too_few = "align_start") |> 
	summarise(sum(!is.na(suffix)))

# customer split name
csn <- cs |> 
	separate_wider_delim(last, delim = " ", 
											 names = c("last", "suffix"), 
											 too_few = "align_start") 

# can we split ll at once?
csn <- customers |> 
	select(name, phone) |> 
	separate_wider_delim(name, delim = " ",
											 names = c("first", "last", "suffix"),
											 too_few = "align_start") |> 
	filter(!is.na(suffix))

csn |> 
	mutate(n_last = nchar(last)) |> 
	filter(n_last == 10) |> # lots have last names of 10 characters
	count(last) # lots of duplicates

# remove "-" from phone number
csn |> 
	mutate(phone_numbers = str_remove_all(phone, "-")) |>
	mutate(last_phone = str_replace_all(last, "[a-cA-C]", "2")) |>
	mutate(last_phone = str_replace_all(last_phone, "[d-fD-F]", "3")) |>
	mutate(last_phone = str_replace_all(last_phone, "[g-iG-I]", "4")) |>
	mutate(last_phone = str_replace_all(last_phone, "[j-lJ-L]", "5")) |>
	mutate(last_phone = str_replace_all(last_phone, "[m-oM-O]", "6")) |>
	mutate(last_phone = str_replace_all(last_phone, "[p-sP-S]", "7")) |>
	mutate(last_phone = str_replace_all(last_phone, "[t-vT-V]", "8")) |>
	mutate(last_phone = str_replace_all(last_phone, "[w-zW-Z]", "9")) |> 
	filter(phone_numbers == last_phone) # no matches
# this should have worked
# this would have worked if I hadn't defined csn to be only those with suffixes.
# Duh!

# maybe do need to keep suffix
# maybe I also messed something up with `csn`, so start again with cusstomers
customers |> 
  select(name, phone) |> 
	separate_wider_delim(name, delim = " ", names = c("first", "last"), too_many = "merge") |> 
#	mutate(last = str_remove_all(last, "\\s|\\.")) |> 
#	mutate(last = str_remove_all(last, "\\.")) |>
#	filter(str_detect(last, "Jr")) |>
	mutate(phone_numbers = str_remove_all(phone, "-")) |> 
	mutate(last_phone = str_replace_all(last, "[a-cA-C]", "2")) |> 
	mutate(last_phone = str_replace_all(last_phone, "[d-fD-F]", "3")) |> 
	mutate(last_phone = str_replace_all(last_phone, "[g-iG-I]", "4")) |> 	
	mutate(last_phone = str_replace_all(last_phone, "[j-lJ-L]", "5")) |> 	
	mutate(last_phone = str_replace_all(last_phone, "[m-oM-O]", "6")) |> 	
	mutate(last_phone = str_replace_all(last_phone, "[p-sP-S]", "7")) |> 	
	mutate(last_phone = str_replace_all(last_phone, "[t-vT-V]", "8")) |> 	
	mutate(last_phone = str_replace_all(last_phone, "[w-zW-Z]", "9")) |> 
	filter(phone_numbers == last_phone) |> 
	pull(phone)
# this is correct: 826-636-2286
# didn't need to take suffixes into account


