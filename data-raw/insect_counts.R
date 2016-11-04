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
  dplyr::select(-dir, -extension)

devtools::use_data(insect_counts, overwrite = TRUE)
