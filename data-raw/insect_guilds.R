library(dplyr)

insect_guilds = readr::read_csv("original/STRIPS1ONealInsect_TaxaFeedingGuilds.csv",
                         na = ".") %>%
  select(taxa, guild)

devtools::use_data(insect_guilds, overwrite = TRUE)
