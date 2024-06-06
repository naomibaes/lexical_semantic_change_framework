# Author: Naomi Baes
# R 4.2.2
# Aim: This script reads CSV files containing count data, extracts target and corpus names from file names, combines the data frames, calculates the sum of counts grouped by year, target, and corpus, and saves the summarized data to a new CSV file.

# Load necessary libraries
library(here)  # here
library(dplyr) # data wrangling
library(tidyr)

# Define the base directory path
base_dir <- here("0.1_descriptives/rel_count_decade/output/warriner_matches")

# Function to extract corpus and target from file names
extract_info <- function(filename) {
  parts <- unlist(strsplit(filename, "[.]"))
  target <- parts[1]
  corpus <- parts[3]
  return(list(target = target, corpus = corpus))
}

# Read CSV files and extract corpus and target names
files <- list.files(base_dir, pattern = "\\.csv$", full.names = TRUE)
data <- lapply(files, function(file) {
  df <- read.csv(file)
  info <- extract_info(basename(file))
  df$target <- info$target
  df$corpus <- info$corpus
  return(df)
})

# Combine all data frames
all_data <- do.call(rbind, data)

# Group by year, target, and corpus, then summarize counts
summary_data <- all_data %>%
  group_by(year, target, corpus) %>%
  summarise(sum_count = sum(count, na.rm = TRUE)) %>%
  arrange(year)

# Save the summary data frame to a CSV file in the output folder
output_path <- here("0.1_descriptives/rel_count_decade/output", "warriner-matched-coll_counts_year.csv")
write.csv(summary_data, output_path, row.names = FALSE)

# Print the summary data frame to verify
print(summary_data)
