# install.packages("tidyverse") # Load all
# library(plyr)
library(dplyr)
library(readr)
library(stringr)
library(ggplot2)

# list the files
files <- list.files(path = "data/usa",pattern = "candy.csv", full.names = T)

# Read the files
candy_data <- lapply(files, read_csv)
#set the names to the list of dataframes
candy_data <- setNames(candy_data, 2009:2014)


# combine the dataframes
candy_usa <- bind_rows(candy_data, .id="year") %>%
  # Combine the categories column due to header mismatch
  mutate(
    candy = ifelse(is.na(candy), X1, candy)) %>%
  # Drop the unamed category column
  select(-X1) # %>%
  # Replace the years by the real values
   # mutate(
     # year = as.integer(year) + 2008)
     # year = as.integer(year),
     # year = recode(year, c(`1`=2009,`2`=2010)))
     # year = mapvalues(all_candy$year, from = 1:6, to = 2009:2014))

#Discovery 1.####
#An elegant workflow solution to read in >1 to many files at once in R and then join
#list.files, lappy, then bind_rows

# Filter the Halloween candies
candy_halloween <- candy_usa %>%
  # filter(candy %in% c(
  #   "SEASONAL NON-CHOCOLATE HALLOWEEN CANDY",
  #   "SEASONAL CHOCOLATE HALLOWEEN CANDY"))
  filter(str_detect(candy,"HALLOWEEN"))

#Discovery 2.#####
#str_detect to grab only bits from vectors within a piped workflow using filter

# Plot
ggplot(candy_halloween, aes(year, `52 Weeks Ending`, group = candy, color = candy)) + 
  geom_point() +
  geom_line() +
  theme(legend.position = "bottom") 

#Discovery 3.####
#re_code as a means to clean up levels

