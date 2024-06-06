# Author: Naomi Baes & Chat GPT
# R 4.2.2
# Note: Have not tried running script yet; the aim is to combine the separate psych and cohacoca files if you want to keep them separate for some reason

#### setup ####
library(dplyr)
library(purrr)
library(here)

# List individual term files
individual_files <- list.files(
  path = here("2_breadth"),
  pattern = "^combined\\.5yr\\.cosine_dissim\\.BERT\\.(psych|cohacoca)\\.csv$",
  full.names = TRUE
)

# Read and combine individual term files for both "cohacoca" and "psych"
combined_data <- bind_rows(lapply(individual_files, function(file) {
  data <- read.csv(file)
  corpus <- ifelse(grepl("psych", file), "psychology", "cohacoca")
  data$corpus <- corpus
  return(data)
}))

# Save the combined data
combined_file <- file.path(here("2_breadth"), "combined_cosine_dissim.csv")
write.csv(combined_data, file = combined_file, row.names = FALSE)
