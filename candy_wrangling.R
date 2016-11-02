install.packages("tidyverse") # Load all
library(dplyr)
library(readr)
library(stringr)
library(ggplot2)

# list the files
files <- list.files(path = "data/usa",pattern = "candy.csv", full.names = T)

# Read the files
l <- lapply(files, read_csv)


# combine the dataframes
d <- bind_rows(l, .id="year") %>%
  mutate(
    candy = ifelse(is.na(candy), X1, candy)) %>%
  select(-X1)  %>%
  mutate(year = as.integer(year) + 2008)
  # mutate(
  #   year = as.integer(year),
  #   year = recode(year, c(`1`=2009,`2`=2010)))

#Discovery 1.####
#An elegant workflow solution to read in >1 to many files at once in R and then join
#list.files, lappy, then bind_rows

# Filter the Halloween candies
h <- d %>%
  # filter(candy %in% c(
  #   "SEASONAL NON-CHOCOLATE HALLOWEEN CANDY",
  #   "SEASONAL CHOCOLATE HALLOWEEN CANDY"))
  filter(str_detect(candy,"HALLOWEEN"))

#Discovery 2.#####
#str_detect to grab only bits from vectors within a piped workflow using filter

# Plot
ggplot(h, aes(year, `52 Weeks Ending`, color = candy)) + 
  geom_point() + 
  geom_line() + 
  theme(legend.position = "bottom") 

#Discovery 3.####
#re_code as a means to clean up levels

