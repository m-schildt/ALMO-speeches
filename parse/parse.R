# This function parses a speech contained in a TXT file
parse <- function(file)
{
  # The solution uses the 'stringr' package
  library(stringr)
  
  # Read file ####
  # Read all characters in the file
  document <- readChar(file, file.info(file)$size)
  
  # Parse speech ####
  # The following regular expression detects the <speaker tags>, taking care of special characters
  pattern <- regex("([A-ZÀ-Ú][ ,\\-A-ZÀ-Ú]+): *")
  # Still doesnt handle speakers whose tag includes title in parentheses
  
  # Prep the document by adding separator characters between the relevant parts: speaker and speech
  prepped_document <- str_replace_all(document, pattern, "##\\1&&")
  
  # Parse each <turn> by splitting the speech into speaker-speech elements 
  parsed_turns <- unlist(str_split(prepped_document, "##"))
  
  # Leave non-speech elements outside (line 1)
  parsed_turns <- parsed_turns[2:length(parsed_turns)]
  
  # Prepare an empty data frame to populate it later
  turns <- data.frame(matrix(NA, nrow = length(parsed_turns), ncol = 3))
  colnames(turns) <- c("turn", "speaker", "speech")
  
  # Populate the data frame with the turns: separated and white space-trimmed speaker and speech
  for(i in 1:length(parsed_turns))
  {
    turns$turn[i] <- i
    turns$speaker[i] <- str_trim(unlist(str_split(parsed_turns[i], "&&"))[1], side = "both")
    turns$speech[i] <- str_trim(unlist(str_split(parsed_turns[i], "&&"))[2], side = "both")
  }
  
  # Remove non-speech components (those after the "[+++++]" string or "©" symbol)
  if(grepl("[+++++]", turns$speech[length(parsed_turns)]) == TRUE)
  {
    turns$speech[length(parsed_turns)] <- unlist(str_split(turns$speech[length(parsed_turns)], "[+++++]"))[1]
  } else
  {
    turns$speech[length(parsed_turns)] <- unlist(str_split(turns$speech[length(parsed_turns)], "©"))[1]
  }
  # This is almost consistent, as sometimes other strings (like "[– – – 0- – –]") are used
  
  # Convert all speakers to title case
  turns$speaker <- str_to_title(turns$speaker, locale = "es")
  # Some words should not be capitalized. May fix this to make more aesthetically appealing.
  
  return(turns)
}
