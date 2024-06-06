# Author: Naomi Baes
# R 4.2.2
# Aim: This script calculates the relative repetitions of collocates by decade for specified terms across different corpora, storing the results in CSV files.

#### Setup ####
library(here) # here
library(dplyr) # data wrangling
library(tidyr) # pivot functions

# define the base directory path
base_dir <- here("data/output/warriner_matches")

terms <- c("distress", "stress", "grief", "worry", "addiction", "anger")

# initialize an empty list to store the input paths
input_paths <- list()

# split the list of terms and iterate over each term
for (term in terms) {
  # construct the file path for each term and add it to the input_paths list
  cohacoca_file_path <- file.path(base_dir, paste0(term, "_warriner.matches.COHCA.csv"))
  input_paths[[paste0(term, "_cohacoca")]] <- cohacoca_file_path
  
  processed_file_path <- file.path(base_dir, paste0(term, "_warriner.matches.psychology.csv"))
  input_paths[[paste0(term, "_processed")]] <- processed_file_path
}

#### Relative Repetitions of Collocates by Decade ####
compute_rel_count <- function(input_path, output_path, word, corpus) {
  # Read input files
  input_data <- read.csv(input_path)
  # Convert 'word' column to character
  input_data$word <- as.character(input_data$word)
  
  count_word_decade <- input_data %>%
    mutate(decade = year - year %% 10) %>%
    group_by(decade, word) %>%
    summarise(count = sum(count)) %>%
    group_by(decade) %>%
    mutate(tot_count = sum(count)) %>%
    ungroup() %>%
    mutate(rel_count = (count / tot_count) * 100) %>%
    select(decade, word, count, tot_count, rel_count)
  
  # Write output file with a unique filename based on the word and corpus
  output_file_path <- file.path(output_path, paste0(word, "_rel.count.decade.", corpus, ".csv"))
  write.csv(count_word_decade, file = output_file_path, row.names = FALSE)
  
  count_word_decade_table <- count_word_decade %>%
    mutate(corpus = corpus) %>%
    group_by(corpus, decade) %>%
    arrange(corpus, decade, desc(rel_count)) %>%
    mutate(rank = row_number()) %>%
    filter(rank <= 10) %>% 
    mutate(rel_count = round(rel_count, 3)) %>%
    select(corpus, decade, word, rel_count, rank)
  
  # Write output file for the table with a unique filename based on the word and corpus
  output_file_path_table <- file.path(output_path, paste0(word, "_rel_count_word_decade_table.", corpus, ".csv"))
  write.csv(count_word_decade_table, file = output_file_path_table, row.names = FALSE)
}

#### Call the function for all input files ####
output_path <- here("data/output/rel_count_decade/warriner_matches")

for (i in seq_along(input_paths)) {
  input_path <- input_paths[[i]]
  word <- strsplit(names(input_paths)[i], "_", fixed = TRUE)[[1]][1]
  
  # Extract the corpus from the input path
  corpus <- ifelse(grepl("_processed", names(input_paths)[i]), "psychology", "COHCA")
  
  compute_rel_count(input_path, output_path, word, corpus)
}