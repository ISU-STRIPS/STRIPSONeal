library(dplyr)
library(tidyr)

my_read_csv = function(f, into) {
  readr::read_csv(f) %>%
    mutate(file=f) %>%
    separate(file, into) 
}

read_dir = function(path, pattern, into) {
  files = list.files(path = path,
                   pattern = pattern,
                   recursive = TRUE,
                   full.names = TRUE)
  plyr::ldply(files, my_read_csv, into = into)
}
