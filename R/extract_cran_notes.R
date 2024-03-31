library(tidyverse)

my_packages <- c("ggdendro", "miniCRAN", "sortable", "sss", "surveydata", "rrd", "rfordummies")


only_mine <- function(x, email = c("apdevries@gmail.com", "andrie@rstudio.com")) {
  ptn <- paste0("(", paste(email, collapse = "|"), ")")
  x %>%
    as_tibble(.name_repair = tolower) %>%
    filter(grepl(ptn, maintainer))
}

pdb <-
  tools::CRAN_package_db() %>%
  only_mine()
pdb



pdb %>%
  select(package, version, maintainer, description, packaged) %>%
  arrange(packaged)

ccr <-
  tools::CRAN_check_results() %>%
  only_mine()

ccr %>%
  filter(status != "OK")


ccd <-
  tools::CRAN_check_details() %>%
  only_mine()

ccd %>%
  filter(status != "OK") %>%
  group_by(package, status, output) %>%
  slice(1) %>%
  select(package, check, status, output)

ccd %>%
  filter(package == "rrd") %>%
  pluck("output")
