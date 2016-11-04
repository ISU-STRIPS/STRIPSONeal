library(dplyr)

source("read_dir.R")

insect_counts = read_dir(path    = "insect",
             pattern = "*.csv",
             into    = c("dir",
                         "year",
                         "month",
                         "day",
                         "watershed",
                         "habitat",
                         "rep",
                         "extension")) %>%
  mutate(date = as.Date(paste(year, month, day, sep="/"))) %>%
  dplyr::select(date, watershed, rep, taxa, count)

devtools::use_data(insect_counts, overwrite = TRUE)
