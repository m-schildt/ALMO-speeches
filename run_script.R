
#load functions
source("parse/parse.R")
source("aggregate.R")

#detect all raw speeches and create a list will all names incl. path
dir_raw = "Data/raw"
txtfiles = list.files(path=dir_raw, pattern="*.txt", full.names=TRUE)

#run parse function on all speeches (a loop might be more appropriate here)
lapply(txtfiles, parse)

#detect all parsed speeches and create a list will all names incl. path
dir_parsed = "Data/parsed"
csvfiles = list.files(path=dir_parsed, pattern="*.csv", full.names=TRUE)

# aggregate all speeches and returns them in a single data frame
speeches_df <- do.call(rbind,lapply(csvfiles, aggregate))

# save aggregated data frame
write.csv(speeches_df,"Data/aggregated/speeches.csv")






