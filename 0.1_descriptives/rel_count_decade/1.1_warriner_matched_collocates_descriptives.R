# Author: Naomi Baes
# R 4.2.2
# Aim: This script compares the counts of terms between Warriner matches and coll files across different corpora, calculates the difference and percentage difference, and stores the information in a data frame, saving it to a CSV file.

library(here)
setwd(here())

# Initialize an empty list to store the input paths
input_paths <- list()

# Define terms without special characters
terms <- c("health", "illness")  # Updated terms

# Define directory paths
warriner_dir <- here("5_thematic_content/ntf_count_decade/output/warriner_matches")
coll_dir <- here("5_thematic_content/ntf_count_decade/input")  # Define the coll_dir variable

# Initialize data frame to store counts and differences
file_info <- data.frame(Label = character(0), Counts_coll = integer(0), Counts_warriner = integer(0), Difference = integer(0))

for (term in terms) {
  for (corpus in c("psych", "cohacoca")) {
    
    # Construct the "coll" file path with the naming convention
    coll_file_path <- file.path(coll_dir, paste0(term, ".combined.coll.repet.", corpus, ".csv"))
    
    # Construct the file path for warriner_matches
    warriner_file_path <- file.path(warriner_dir, paste0(term, "_warriner.matches.", corpus, ".csv"))
    
    cat("Checking coll file:", coll_file_path, "\n")  # Debug line
    cat("Checking warriner file:", warriner_file_path, "\n")  # Debug line
    
    # Calculate counts for warriner_matches
    counts_warriner <- if (file.exists(warriner_file_path)) {
      data <- read.csv(warriner_file_path)
      sum_counts_warriner <- sum(data$count)
    } else {
      cat("Warning: Warriner file not found -", warriner_file_path, "\n")
      sum_counts_warriner <- 0
    }
    
    # Calculate counts for coll
    counts_coll <- if (file.exists(coll_file_path)) {
      coll_data <- read.csv(coll_file_path)
      sum_counts_coll <- sum(coll_data$count)
    } else {
      cat("Warning: Coll file not found -", coll_file_path, "\n")
      sum_counts_coll <- 0
    }
    
    # Calculate difference
    difference <- sum_counts_coll - sum_counts_warriner
    
    # Calculate % difference
    perc_diff <- ((sum_counts_warriner/sum_counts_coll)*100)
    
    # Extract the label for better file identification
    label <- paste(term, corpus, sep = ".")
    
    # Store file info in data frame
    file_info <- rbind(file_info, data.frame(Label = label, Counts_coll = sum_counts_coll, Counts_warriner = sum_counts_warriner, Difference = difference, perc_diff = perc_diff))
  }
}

# Check if directories exist
cat("Input directory exists:", dir.exists(coll_dir), "\n")
cat("Output directory exists:", dir.exists(warriner_dir), "\n")

# Check if files exist
cat("Coll files exist:", sapply(file.path(coll_dir, paste0(terms, ".combined.coll.repetpsych.csv")), file.exists), "\n")
cat("Warriner files exist:", sapply(file.path(warriner_dir, paste0(terms, "_warriner.matches.psych.csv")), file.exists), "\n")


# Print the label, counts(coll), counts(warriner), and difference
print(file_info)

# Specify the file path for saving the file_info data frame
output_file_path <- here("file_info.csv")

# Save the file_info data frame to a CSV file
write.csv(file_info, file = output_file_path, row.names = FALSE)

