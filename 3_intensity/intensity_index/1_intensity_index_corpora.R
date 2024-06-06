library(here)
library(dplyr)
library(tidyr)
library(purrr)

intensity <- c("great", "intense", "severe", "harsh", "major", "extreme", "powerful", "serious", "devastating", "destructive", "debilitating")

# Function to create intensity index CSV for health, illness, and perception
create_intensity_index <- function(denominator_file, health_file, illness_file, perception_file, 
                                   output_filename_health, output_filename_illness, output_filename_perception) {
  # Load files
  print(paste("Loading files:", denominator_file, health_file, illness_file, perception_file))
  
  denominator_data <- read.csv(denominator_file)
  health_data <- read.csv(health_file)
  illness_data <- read.csv(illness_file)
  perception_data <- read.csv(perception_file)
  
  print("Files loaded successfully.")
  
  health_target_freq <- denominator_data %>% filter(target == "health") %>% select(c(year, target_freq))
  illness_target_freq <- denominator_data %>% filter(target == "illness") %>% select(c(year, target_freq))
  perception_target_freq <- denominator_data %>% filter(target == "perception") %>% select(c(year, target_freq))
  
  intensity_amod_health <- list(intensity = health_data %>% filter(word %in% intensity))
  intensity_amod_illness <- list(intensity = illness_data %>% filter(word %in% intensity))
  intensity_amod_perception <- list(intensity = perception_data %>% filter(word %in% intensity))
  
  sum_count_intensity_health <- intensity_amod_health$intensity %>%
    group_by(year) %>%
    summarize(sum_count_intensity_health = sum(count))
  
  sum_count_intensity_illness <- intensity_amod_illness$intensity %>%
    group_by(year) %>%
    summarize(sum_count_intensity_illness = sum(count))
  
  sum_count_intensity_perception <- intensity_amod_perception$intensity %>%
    group_by(year) %>%
    summarize(sum_count_intensity_perception = sum(count))
  
  all_years <- data.frame(year = seq(1970, 2016, by = 1))
  
  sum_count_intensity_health <- all_years %>%
    left_join(sum_count_intensity_health, by = "year") %>%
    mutate_all(~replace(., is.na(.), 0)) %>%
    left_join(health_target_freq, by = "year") %>%
    mutate(
      intensity_index = sum_count_intensity_health / target_freq
    )
  
  sum_count_intensity_illness <- all_years %>%
    left_join(sum_count_intensity_illness, by = "year") %>%
    mutate_all(~replace(., is.na(.), 0)) %>%
    left_join(illness_target_freq, by = "year") %>%
    mutate(
      intensity_index = sum_count_intensity_illness / target_freq
    )
  
  sum_count_intensity_perception <- all_years %>%
    left_join(sum_count_intensity_perception, by = "year") %>%
    mutate_all(~replace(., is.na(.), 0)) %>%
    left_join(perception_target_freq, by = "year") %>%
    mutate(
      intensity_index = sum_count_intensity_perception / target_freq
    )
  
  # Define the output directory paths and write to csv
  output_path_health <- here("3_intensity/intensity_index/output/intensity_index", output_filename_health)
  write.csv(sum_count_intensity_health, file = output_path_health, row.names = FALSE)
  
  output_path_illness <- here("3_intensity/intensity_index/output/intensity_index", output_filename_illness)
  write.csv(sum_count_intensity_illness, file = output_path_illness, row.names = FALSE)
  
  output_path_perception <- here("3_intensity/intensity_index/output/intensity_index", output_filename_perception)
  write.csv(sum_count_intensity_perception, file = output_path_perception, row.names = FALSE)
  
  print(paste("Files written:", output_filename_health, output_filename_illness, output_filename_perception))
}

# Call the function for different combinations
create_intensity_index(
  denominator_file = here("3_intensity/intensity_index/input/targets.year.freq.psych.csv"),
  health_file = here("3_intensity/intensity_index/input/amod.health.year.count.psych.csv"),
  illness_file = here("3_intensity/intensity_index/input/amod.illness.year.count.psych.csv"),
  perception_file = here("3_intensity/intensity_index/input/amod.perception.year.count.psych.csv"),
  output_filename_health = "health_intensity_index_psych.csv",
  output_filename_illness = "illness_intensity_index_psych.csv",
  output_filename_perception = "perception_intensity_index_psych.csv"
)

create_intensity_index(
  denominator_file = here("3_intensity/intensity_index/input/targets.year.freq.cohacoca.csv"),
  health_file = here("3_intensity/intensity_index/input/amod.health.year.count.cohacoca.csv"),
  illness_file = here("3_intensity/intensity_index/input/amod.illness.year.count.cohacoca.csv"),
  perception_file = here("3_intensity/intensity_index/input/amod.perception.year.count.cohacoca.csv"),
  output_filename_health = "health_intensity_index_cohacoca.csv",
  output_filename_illness = "illness_intensity_index_cohacoca.csv",
  output_filename_perception = "perception_intensity_index_cohacoca.csv"
)

# List individual term files
individual_files <- list.files(
  path = here("3_intensity/intensity_index/output/intensity_index"),
  pattern = "(health|illness|perception)_intensity_index_(cohacoca|psych)\\.csv$",
  full.names = TRUE
)

# Read and combine individual term files
combined_data_corpora <- map_dfr(individual_files, ~ {
  data <- read.csv(.x)
  data <- data[, c("year", "intensity_index")]  # Keep only "year" and "intensity_index" columns
  
  # Extracting corpus and target from the filename using regular expressions
  target <- sub(".*/(\\w+)_intensity_index_(\\w+)\\.csv", "\\1", .x)
  corpus <- sub(".*/(\\w+)_intensity_index_(\\w+)\\.csv", "\\2", .x)
  
  # Assigning the correct values to "corpus" and "target" columns
  data$target <- target
  data$corpus <- corpus
  
  return(data)
})

# Save the combined data for both corpora
combined_data_corpora_file <- file.path(here("3_intensity/intensity_index/output/intensity_index"), "combined.intensity_index.corpora.csv")
write.csv(combined_data_corpora, file = combined_data_corpora_file, row.names = FALSE)

# List all files in the output directory
all_files <- list.files(
  path = here("3_intensity/intensity_index/output/intensity_index"),
  full.names = TRUE
)

# Identify files to remove
files_to_remove <- all_files[!grepl("combined\\.intensity_index.corpora\\.csv$", all_files)]

# Remove files
if (length(files_to_remove) > 0) {
  file.remove(files_to_remove)
  cat("Removed the following files after combining them in the combined file:\n")
  cat(files_to_remove, sep = "\n")
} else {
  cat("No files to remove.\n")
}

print("Script completed successfully.")
