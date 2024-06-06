# Author: Naomi Baes and Chat GPT
# R 4.2.2
# Aim: Compute pathologization index for each target and corpus

#### setup ####
library(here) # here
library(dplyr) # data wrangling
library(tidyr) # pivot functions
library(purrr)
library(stringr)

#### Combined targets ####
# Set base directory path
base_dir <- here("5_thematic_content/pathologization/input")

# Define the targets
targets <- c("health", "illness", "perception")

# Initialize input paths list
input_paths <- list()

# Iterate over each target
for (target in targets) {
  # Construct file paths
  cohacoca_file_path <- file.path(base_dir, paste0(target, ".combined.coll.repet.cohacoca.csv"))
  psychology_file_path <- file.path(base_dir, paste0(target, ".combined.coll.repet.psych.csv"))
  
  # Store input paths in the list
  input_paths[[paste0(target, "_cohacoca")]] <- cohacoca_file_path
  input_paths[[paste0(target, "_psych")]] <- psychology_file_path
}

# pathologization list (17 terms)
pathologization <- c("ailment", "clinical", "clinic", "cure", "diagnosis", "disease", "disorder", "ill", "illness", "medical", "medicine", "pathology", "prognosis", "sick", "sickness", "symptom", "treatment")

#### pathologization target counts ####

# Define a function to compute pathologization counts for an input file and write the output to a file
compute_pathologization_counts <- function(input_path, output_path, pathologization) {
  input_data <- read.csv(input_path, stringsAsFactors = FALSE)
  input_data$count <- as.numeric(input_data$count)
  
  # Create a data frame with all years from min to max
  all_years <- data.frame(year = min(input_data$year):max(input_data$year))
  
  total_sum_counts_year <- input_data %>%
    group_by(year) %>%
    summarize(total_sum_counts = sum(count, na.rm = TRUE))
  
  words_list <- list(
    pathologization = input_data %>% filter(word %in% pathologization))
  
  sum_count_pathologization <- words_list$pathologization %>%
    group_by(year) %>%
    summarize(sum_count_pathologization = sum(count))
  
  # Merge with all years to ensure 0 counts for missing years
  year_list <- all_years %>%
    left_join(total_sum_counts_year, by = "year") %>%
    left_join(sum_count_pathologization, by = "year") %>%
    mutate(
      total_sum_counts = ifelse(is.na(total_sum_counts), 0, total_sum_counts),
      sum_count_pathologization = ifelse(is.na(sum_count_pathologization), 0, sum_count_pathologization),
      pathologization_index = sum_count_pathologization / total_sum_counts
    ) %>%
    select(year, total_sum_counts, sum_count_pathologization, pathologization_index)
  
  write.csv(year_list, file = output_path, row.names = FALSE)
}


# Define the output directory path
output_dir <- here("5_thematic_content/pathologization/output")

# Call the function for all input files
for (i in seq_along(input_paths)) {
  input_path <- input_paths[[i]]
  
  # Extract the target and corpus from the input path
  target_corpus <- names(input_paths)[i]
  target <- gsub("_cohacoca|_psych", "", target_corpus)
  corpus <- ifelse(grepl("_cohacoca", target_corpus), "cohacoca", "psych")
  
  # Define the output filename based on target and corpus
  output_filename <- paste0(target, "_pathologization_", corpus, ".csv")
  output_path <- file.path(output_dir, output_filename)
  
  # Call the function
  compute_pathologization_counts(input_path, output_path, pathologization)
}

#### Combined Output File Creation ####

# Read and combine individual target files for all targets
combined_data <- map_dfr(list.files(output_dir, full.names = TRUE), ~ {
  data <- read.csv(.x)
  target_corpus <- str_extract(.x, "(health|illness|perception)_\\w+")
  target <- str_extract(target_corpus, "(health|illness|perception)")
  corpus <- str_extract(target_corpus, "(cohacoca|psych)")
  data <- data %>%
    select(year, pathologization_index) %>%
    mutate(corpus = corpus, target = target) %>%
    mutate(pathologization_index = ifelse(pathologization_index == 0, NA, pathologization_index))
  return(data)
})

# Save the combined data
combined_file <- file.path(output_dir, "combined.pathologization_index.corpora.csv")
write.csv(combined_data, file = combined_file, row.names = FALSE)

# Define the output file to keep
final_output_file <- file.path(output_dir, "combined.pathologization_index.corpora.csv")

# List all files in the output directory
all_files <- list.files(output_dir, full.names = TRUE)

# Identify files to remove
files_to_remove <- all_files[!grepl("combined.pathologization_index.corpora.csv$", all_files)]

# Remove files
if (length(files_to_remove) > 0) {
  file.remove(files_to_remove)
  cat("Removed the following files after combining them in the combined file:\n")
  cat(files_to_remove, sep = "\n")
} else {
  cat("No files to remove.\n")
}
