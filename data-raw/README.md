# insect 

This README describes how to create the `insect` data set. 

## To long didn't read

Run `run_all.R` (which also recreates all other data sets) or 

1. Replace files in original/
1. Run extract_insect.R
1. Run insect_counts.R

## Details

original/ contains the original data files that were received

the `extract_insect.R` script extracts data from original/ files and rewrites
them into insect/ in the file structure that seems more reasonable (to me)

insect/ contains the data in a succinct format

insect_counts.R creates the insect count data set from the files in insect/

insect_guilds.R creates the insect guild data set from the files in insect/
