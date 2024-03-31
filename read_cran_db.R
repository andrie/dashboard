library(tidyverse)
library(dplyr)

getOption("repos")
options(repos = "https://cran.r-project.org")

pdb <- tools::CRAN_package_db() %>% as_tibble(.name_repair = tolower)

mine <-
  pdb %>%
  filter(
    str_detect(`maintainer`, "apdevries@gmail.com") |
      str_detect(`maintainer`, "andrie@rstudio.com")
  ) %>%
  select(package, version, depends, author, copyright, description, maintainer)

# if (interactive()) { mine %>% view("my_packages") }

my_pkgs <- mine %>% pluck("package")


ccr <-
  tools::CRAN_check_results() %>%
  as_tibble(.name_repair = tolower) %>%
  filter(package %in% my_pkgs)

ccr %>%
  filter(status == "ERROR") %>%
  arrange(package)


ccr %>%
  filter(status != "OK") %>%
  arrange(package)

ccr %>%
  group_by(status) %>%
  tally()



my_status <-
  tools::summarize_CRAN_check_status(packages = my_pkgs)

my_status

# my_status[[3]] %>% cat()
