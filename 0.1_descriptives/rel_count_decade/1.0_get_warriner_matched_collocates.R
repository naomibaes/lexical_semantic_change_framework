# Author: Naomi Baes
# R 4.2.2
# Aim: This script computes matches between the words (lemmas) in the input files and the Warriner ratings data. It then saves the matched data for each word and corpus combination into separate CSV files in the specified output directory.

#### setup ####
library(here)  # here
library(dplyr) # data wrangling

# define the base directory path
base_dir <- here("0.1_descriptives/rel_count_decade/input")

warriner_path <- here(base_dir, "warriner_rat.csv") # warriner rat data
warriner_rat <- read.csv(warriner_path) 

# Updated terms
targets <- c("health","illness","perception")

# initialize an empty list to store the input paths
input_paths <- list()

# split the list of terms and iterate over each term
for (target in targets) {
  # construct the file paths for each term and add them to the input_paths list
  for (corpus in c("psych", "cohacoca")) {
    file_suffix <- ifelse(corpus == "psych", "psych", "cohacoca")
    file_path <- file.path(base_dir, paste0(target, ".combined.coll.repet.", corpus, ".csv"))
    input_paths[[paste0(target, "_", file_suffix)]] <- here(file_path)
  }
}

# Create the necessary output directories if they don't exist
output_base_dir <- here("0.1_descriptives/rel_count_decade/output")
output_warriner_matches_dir <- file.path(output_base_dir, "warriner_matches")
output_warriner_matches_ranked_dir <- file.path(output_base_dir, "warriner_matches_ranked")

if (!dir.exists(output_warriner_matches_dir)) {
  dir.create(output_warriner_matches_dir, recursive = TRUE)
}

if (!dir.exists(output_warriner_matches_ranked_dir)) {
  dir.create(output_warriner_matches_ranked_dir, recursive = TRUE)
}

# Warriner matches function
compute_warriner_matches <- function(input_path, output_path, word, corpus) {
  # Create the output folder if it doesn't exist
  if (!dir.exists(output_path)) {
    dir.create(output_path, recursive = TRUE)
  }
  
  warriner_matches_folder <- file.path(output_path)
  
  # Read input files
  input_data <- read.csv(input_path, row.names = NULL, strip.white = TRUE)  # Specify row names as NULL
  
  # Cleaning
  input_data <- input_data %>%
    mutate(count = as.numeric(count))
  
  warriner_data <- inner_join(warriner_rat, input_data, by = "word")
  
  # Select relevant columns
  selected_data <- warriner_data %>%
    select(word, year, count)
  
  # Output selected_data
  if (corpus %in% c("cohacoca", "count.cohacoca", "psych")) {
    warriner_matches_file <- file.path(warriner_matches_folder, paste0(word, ".warriner_matches.", corpus, ".csv"))
    write.csv(selected_data, file = warriner_matches_file, row.names = FALSE)
  }
}

# Call the function for all input files
for (i in seq_along(input_paths)) {
  input_path <- input_paths[[i]]
  parts <- strsplit(names(input_paths)[i], "_", fixed = TRUE)[[1]]
  word <- parts[1]
  corpus <- parts[2]
  
  output_path <- output_warriner_matches_dir
  compute_warriner_matches(input_path, output_path, word, corpus)
}
