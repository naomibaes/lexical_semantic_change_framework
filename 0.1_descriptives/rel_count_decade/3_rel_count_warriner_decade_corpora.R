# Author: Naomi Baes
# R 4.2.2
# Aim: this script processes data related to targets from the "warriner_matches" folder, calculates the relative repetitions of collocates by decade for each term and corpus, and saves the results in CSV files.

#### Setup ####
library(here) # here
library(dplyr) # data wrangling
library(tidyr) # pivot functions

# define the base directory path
base_dir <- here("0.1_descriptives/rel_count_decade/output/warriner_matches")

targets <- c("health", "illness", "perception")

stop_words <- c("be", "have", "do", "say")

# Initialize an empty list to store the input paths
input_paths <- list()

# Split the list of terms and iterate over each term
for (target in targets) {
  # Construct the file path for each term and add it to the input_paths list
  cohacoca_file_path <- file.path(base_dir, paste0(target, ".warriner_matches.cohacoca.csv"))
  input_paths[[paste0(target, ".cohacoca")]] <- cohacoca_file_path
  
  psych_file_path <- file.path(base_dir, paste0(target, ".warriner_matches.psych.csv"))
  input_paths[[paste0(target, ".psych")]] <- psych_file_path
}

#### Relative repetitions of collocates by decade ####
compute_rel_count <- function(input_path, output_path, target, corpus) {
  # Read input files
  input_data <- read.csv(input_path)
  # Convert 'word' column to character
  input_data$word <- as.character(input_data$word)
  
  # Filter stop words
  input_data <- input_data %>%
      filter(!word %in% stop_words)  # Filter out stop words before processing

  count_word_decade <- input_data %>%
    mutate(decade = year - year %% 10) %>%
    group_by(decade, word) %>%
    summarise(count = sum(count)) %>%
    group_by(decade) %>%
    mutate(tot_count = sum(count)) %>%
    ungroup() %>%
    mutate(rel_count = (count / tot_count) * 100) %>%
    select(decade, word, count, tot_count, rel_count)
  
  # Ensure that the output directory exists
  if (!dir.exists(output_path)) {
    dir.create(output_path, recursive = TRUE)
  }
  
  # Write output file with a unique filename based on the target and corpus
  output_file_path <- file.path(output_path, paste0(target, ".rel_count.decade.table.", corpus, ".csv"))
  write.csv(count_word_decade, file = output_file_path, row.names = FALSE)
  
  count_word_decade_table <- count_word_decade %>%
    mutate(corpus = corpus) %>%
    group_by(corpus, decade) %>%
    arrange(corpus, decade, desc(rel_count)) %>%
    mutate(rank = row_number()) %>%
    filter(rank <= 10) %>% 
    mutate(rel_count = round(rel_count, 3)) %>%
    select(corpus, decade, word, rel_count, rank)
  
  # Write output file for the table with a unique filename based on the target and corpus
  output_file_path_table <- file.path(output_path, paste0(target, ".rel_count.decade.table.", corpus, ".ranked.csv"))
  write.csv(count_word_decade_table, file = output_file_path_table, row.names = FALSE)
}

#### Call the function for all input files ####
output_path <- here("0.1_descriptives/rel_count_decade/output/warriner_matches_ranked")

for (i in seq_along(input_paths)) {
  input_path <- input_paths[[i]]
  name_parts <- strsplit(names(input_paths)[i], ".", fixed = TRUE)[[1]]
  target <- name_parts[1]  # Extract target from the filename
  
  # Extract the corpus from the input path
  corpus <- ifelse(grepl("psych", names(input_paths)[i]), "psychology", "cohacoca")
  
  # Call the function with the correct target
  compute_rel_count(input_path, output_path, target, corpus)
}
