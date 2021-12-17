# This function aggregates a speech contained in a CSV file and returns a data frame
aggregate <- function(file) {
  
  date <- substring(file, 10,19)
  try({
    
    parsed_speech <- read.csv(file = file, header = TRUE) %>%
      select(-X,turn) %>% # 
      group_by(speaker) %>% 
      summarize(speech = paste(speech, collapse = " \n ")) %>% # combine text of each speaker 
      mutate(Date = date, .before = speaker)
    
    
  })
  
  return(parsed_speech)
  
}
