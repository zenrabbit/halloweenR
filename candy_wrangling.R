install.packages("tidyverse") # Load all
library(dplyr)
library(readr)
library(stringr)
library(ggplot2)

files <- list.files(path = "data/usa",pattern = "candy.csv", full.names = T)
l <- lapply(files, read_csv)
d <- bind_rows(l, .id="year") %>%
  mutate(
    candy = ifelse(is.na(candy), X1, candy)) %>%
  select(-X1)  %>%
  mutate(year = as.integer(year) + 2008)
  # mutate(
  #   year = as.integer(year),
  #   year = recode(year, c(`1`=2009,`2`=2010)))
  
str(d)

h <- d %>%
  # filter(candy %in% c(
  #   "SEASONAL NON-CHOCOLATE HALLOWEEN CANDY",
  #   "SEASONAL CHOCOLATE HALLOWEEN CANDY"))
  filter(str_detect(candy,"HALLOWEEN"))

ggplot(h, aes(year, `52 Weeks Ending`, color = candy)) + 
  geom_point() + 
  geom_line() + 
  theme(legend.position = "bottom") 

