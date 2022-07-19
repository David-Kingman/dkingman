# Attach packages
library(tidyverse)
library(here)

# Import
galton_height_data <- readr::read_tsv(here('data-raw', 'galton_height_data.txt'))

# Wrangle
galton_height_data <- 
  galton_height_data %>% 
  select(subject_height = Height,
         subject_father_height = Father,
         subject_mother_height = Mother,
         subject_sex = Gender,
         family_id = Family,
         number_of_children_in_family = Kids) %>% 
  mutate(subject_sex = as_factor(subject_sex))

# Export
usethis::use_data(galton_height_data, overwrite = TRUE)