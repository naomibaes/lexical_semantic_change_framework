# Author: Naomi Baes
# R 4.2.2
# Aim: This script will compute valence indices and store the results in the output folder

#### setup ####
library(here)  # here
library(dplyr) # data wrangling
library(tidyr) # pivot functions
library(purrr)

# define the base directory path
base_dir <- here("1_sentiment/input/")

warriner_path <- here(base_dir, "warriner_rat.csv") # warriner rat data
warriner_rat <- read.csv(warriner_path)

terms <- c("health|illness|perception")  # Updated terms

# initialize an empty list to store the input paths
input_paths <- list()

# split the list of terms and iterate over each term
terms <- unlist(strsplit(terms, "|", fixed = TRUE))

for (full_term in terms) {
  # split the full term into its components
  term_components <- strsplit(full_term, "_", fixed = TRUE)[[1]]
  word <- term_components[1]
  suffix <- term_components[2]
  
  for (corpus in c("psych", "cohacoca")) {
    file_path <- file.path(base_dir, paste0(word, ".combined.coll.repet.", corpus, ".csv"))
    input_paths[[paste0(full_term, "_", corpus)]] <- here(file_path)
  }
}

#### Valence rat indices ####
compute_valence_indices <- function(input_path, output_path, word, corpus) {
  valence_indices_folder <- file.path(output_path)
  
  # Read input files
  input_data <- read.csv(input_path, row.names = NULL, strip.white = TRUE)
  
  # Debugging: Print information about the corpus and word
  cat("Corpus:", corpus, "\tWord:", word, "\n")
  
  # Cleaning
  input_data$count <- as.numeric(input_data$count)
  input_data$word <- as.character(input_data$word)
  input_data <- input_data %>% filter(word != "")
  
  warriner_data <- inner_join(warriner_rat, input_data, by = "word")
  
  # Compute weighted sum by year and word
  warriner_data <- warriner_data %>%
    mutate(count = as.numeric(count), year = as.numeric(year)) 
  warriner_data2 <- warriner_data %>% 
    mutate(V.prod = V.Mean.Sum * count) %>%
    group_by(year) %>%
    summarize(sumVprod.word = sum(V.prod),
              sum_counts = sum(count)) %>%
    ungroup()
  
  # Fill in 0 for years with no counts
  all_years <- seq(min(warriner_data2$year), max(warriner_data2$year))
  warriner_data2 <- merge(warriner_data2, data.frame(year = all_years), all = TRUE)
  warriner_data2[is.na(warriner_data2)] <- 0
  
  # Compute final index
  warriner_data3 <- warriner_data2 %>%
    mutate(valence_index = ifelse(sum_counts == 0, 0, round(sumVprod.word / sum_counts, 3))) %>%
    select(year, valence_index) %>%
    ungroup()
  
  # Write output file with a unique filename based on the word and corpus
  valence_indices_file <- file.path(valence_indices_folder, paste0(word, "_valence.indices.", corpus, ".csv"))
  cat("Output Filename:", valence_indices_file, "\n")
  # Create directories and display warnings if any
  dir.create(dirname(valence_indices_file), recursive = TRUE)
  write.csv(warriner_data3, file = valence_indices_file)
}

# Call the function for all input files
for (i in seq_along(input_paths)) {
  input_path <- input_paths[[i]]
  parts <- strsplit(names(input_paths)[i], "_", fixed = TRUE)[[1]]
  word <- parts[1]
  corpus <- parts[2]
  
  output_path <- here("1_sentiment/output")
  
  # Call the function for terms not related to "warriner.matches"
  compute_valence_indices(input_path, output_path, word, corpus)
}

# Combine files

# List individual term files
individual_files <- list.files(
  path = here("1_sentiment/output"),
  pattern = "(health|illness|perception)_valence.indices.(cohacoca|psych)\\.csv$",
  full.names = TRUE
)

# Read and combine individual term files for all terms
combined_data <- map_dfr(individual_files, ~ {
  data <- read.csv(.x)
  corpus <- ifelse(grepl("psych", .x), "psychology", "cohacoca")
  target <- gsub("_valence.indices.(cohacoca|psych)\\.csv", "", basename(.x))
  data$corpus <- corpus
  data$target <- target
  return(data)
}) %>%
  # Replace 0 values in valence_index with NA
  mutate(valence_index = ifelse(valence_index == 0, NA, valence_index))

# Save the combined data
combined_file <- file.path(here("1_sentiment/output"), "combined.valence_index.corpora.csv")
write.csv(combined_data, file = combined_file, row.names = FALSE)

# Remove files in the output folder that are not combined_valence_indices.csv
output_folder <- here("1_sentiment/output")
all_files <- list.files(output_folder, full.names = TRUE)
files_to_remove <- all_files[!grepl("combined.valence_index.corpora\\.csv$", all_files)]

if (length(files_to_remove) > 0) {
  file.remove(files_to_remove)
  cat("Removed the following files after combining them in the combined file:\n")
  cat(files_to_remove, sep = "\n")
} else {
  cat("No files to remove.\n")
}
