library(tidyverse)
customers <- read_csv(here::here("5784", "data", "noahs-customers.csv"))

customers |> 
	summarise(min_year = min(birthdate),
						max_year = max(birthdate))

# Years of the Rabbit
browseURL("https://en.wikipedia.org/wiki/Rabbit_(zodiac)")

# Find Cancer star signs born in the Year of the Rabbit
rc_customers <- customers |> 
	filter(birthdate >= ymd("1939-06-21") & birthdate <= ymd("1939-07-22") |
				 birthdate >= ymd("1951-06-21") & birthdate <= ymd("1951-07-22") |
				 birthdate >= ymd("1963-06-21") & birthdate <= ymd("1963-07-22") |
				 birthdate >= ymd("1975-06-21") & birthdate <= ymd("1975-07-22") |
				 birthdate >= ymd("1987-06-21") & birthdate <= ymd("1987-07-22") |
				 birthdate >= ymd("1999-06-21") & birthdate <= ymd("1999-07-22") |
				 birthdate >= ymd("2011-06-21") & birthdate <= ymd("2011-07-22") 
	) 

# We know that the guy we're looking for lives in the same meighbourhood as the contractor.
# So where does the contractor live?
# From Day 2, contractor has ID 1475

neighborhood <- customers |> 
	filter(customerid == 1475) |> 
	pull(citystatezip)

rc_customers |> 
	filter(citystatezip == neighborhood) |> 
	pull(phone)
# correct: 917-288-9635
