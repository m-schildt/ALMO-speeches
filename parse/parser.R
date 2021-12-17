# This solution uses {stringr}; perhaps {base} would be better
library(stringr)

## Read file (pick any example, I used the one we discussed in the call)
# Choose file to read
file <- "txts/2018-12-11 no. 2.txt"
# Read all characters in the file
speech <- readChar(file, file.info(file)$size)

# This is the pattern that so far returns the speakers correctly
pattern <- "([ A-ZÀ-Ú])+:"

# To demonstrate the pattern, run the following
str_extract_all(speech, pattern)
# It parses all speakers; has some leading and trailing white space that can be removed later

## The strategy now is to place markers to do a second round of parsing
# This captures the speaker
str_extract("SPEAKER: Lorem ipsum.", pattern)
# This pads the speaker with separator characters, I picked "#"; the '\\0' is a place holder for the matched string
str_replace("SPEAKER: Lorem ipsum.", pattern, "#\\0#")

# Those were examples, now do this for the whole file to prep the speech for splitting
prepped_speech <- str_replace_all(speech, pattern, "#\\0#")

# This splits it row by row, but of course we need speaker and speech on the same column
parsed_speech <- as.data.frame(str_split(prepped_speech, "#"), col.names = "A")
# Marco |& Gülce: here is where I need your help
# Can you figure out how to parse this so that we have speaker and speech in every row?
# Also, this particular file has the speaker-with-no-tag problem
# It's good that we caught it here, because there may be several instances

## Tidy the data frame a bit
# Add turn and place before 'speech' column
parsed_speech$turn <- 1:dim(parsed_speech)[1]
parsed_speech <- parsed_speech[, c(2, 1)]

# Remove colon from speaker

# Remove leading and trailing white space from speaker and speech
str_trim(???, side = "both")

## Notes
# It seems only government officials get their names in all caps, the rest get "PREGUNTA" as label
