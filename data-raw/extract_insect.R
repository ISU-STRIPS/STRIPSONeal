library(dplyr)
library(tidyr)

sites_to_watershed = readr::read_csv("original/sites_to_watershed.csv")

d2009 = readr::read_csv("original/STRIPS1ONealInsectData2009.csv") %>%
  dplyr::select(-Month, -Block, -Treatment, -`trt REP`) %>%
  gather(taxa, count, -Habitat, -Date, -Site, -Partition, -Sample_REP)

d2010 = readr::read_csv("original/STRIPS1ONealInsectData2010.csv") %>%
  mutate(Site = Plot_ID) %>% # to be consistent with 2009
  dplyr::select(-Month, -Block, -Treatment, -trt_REP,
         -Comments, -Person_who_ID, -`num_times_ID'd`, -Plot_ID) %>%
  gather(taxa, count, -Habitat, -Date, -Site, -Partition, -Sample_REP)

# Combine 2009 and 2010
d20092010 = bind_rows(d2009,d2010) %>%
  mutate(date = as.Date(Date, format="%m_%d_%Y"),
         habitat = plyr::revalue(as.character(Habitat),
                                 c("1"="prairie",
                                   "2"="crop")),
         Site = substr(Site, 1, 3)) %>%
  rename(rep = Sample_REP) %>%
  left_join(sites_to_watershed, by="Site") %>%
  dplyr::select(taxa, count, date, habitat, watershed, rep)

# 2011
d2011 = readr::read_csv("original/STRIPS1ONealInsectData2011.csv")  %>%
  mutate(site = plyr::revalue(BLCK, c("B"="Basswood",
                                      "I"="Interim",
                                      "W"="Orbweaver")),
         rep = as.numeric(plyr::revalue(SUB, c("a"=1,"b"=2,"c"=3))),
         watershed = paste0(site, PLOT),
         habitat = plyr::revalue(habitat, c("C"="crop","P"="prairie")),
         date = as.Date(Date, format="%m/%d/%Y")) %>%
  dplyr::select(-id, -BLCK, -PLOT, -TRT, -SUB, -Date, -site) %>%
  gather(taxa, count, -watershed, -habitat, -date, -rep)


# Combine 2009-2010 with 2011
insect = bind_rows(d20092010,d2011)



################################################
# Write files
################################################

# Function to write csv file for individual dataset
my_write_csv = function(d) {
  # Extract unique values for this dataset
  year  = format(unique(d$date),'%Y')
  month = format(unique(d$date),'%m')
  day   = format(unique(d$date),'%d')

  watershed = unique(d$watershed)
  habitat   = unique(d$habitat)
  rep       = unique(d$rep)

  # Create directories if needed
  dr = list("insect",year, month, day, watershed, habitat)
  for (i in seq_along(dr)) {
    d1 = paste(dr[1:i], collapse="/")
    if (!dir.exists(d1)) dir.create(d1)
  }

  readr::write_csv(d %>% dplyr::select(taxa, count),
                   path = paste0(d1,"/",rep,".csv"))

  return(data.frame(a=1)) # to avoid Error in do()
}

# Write files
insect %>%
  mutate(count = ifelse(count==0, NA, count)) %>%
  na.omit %>%
  group_by(date, watershed, habitat, rep) %>%
  do(my_write_csv(.))
