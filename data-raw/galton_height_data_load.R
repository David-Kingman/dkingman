# Install and attach packages
if (!'pacman' %in% installed.packages()[, 'Package']) install.packages('pacman')
pacman::p_load(char = c('tidyverse', 'here'), update = FALSE)

# Import
galton_height_data <- readr::read_tsv(here('data-raw', 'galton_height_data.txt'))

# Wrangle
galton_height_data <- 
  galton_height_data %>% 
  # Rename columns
  select(subject_height = Height,
         subject_father_height = Father,
         subject_mother_height = Mother,
         subject_sex = Gender,
         family_id = Family,
         number_of_children_in_family = Kids) %>% 
  # Transform columns
  mutate(subject_sex = as_factor(subject_sex))

# Export
usethis::use_data(galton_height_data, overwrite = TRUE)
