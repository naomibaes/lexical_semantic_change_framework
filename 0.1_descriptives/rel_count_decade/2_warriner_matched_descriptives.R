# Author: Naomi Baes
# R 4.2.2
# Aim: This script reads counts of specific terms from both a "coll" folder and a "warriner_matches" folder, calculates their differences, and stores the results in a data frame, which is then saved as a CSV file.

# Initialize an empty list to store the input paths
input_paths <- list()

# Define terms without special characters
targets <- c("health", "illness", "perception")  # Updated terms

# Define directory paths
warriner_dir <- here("0.1_descriptives/rel_count_decade/output/warriner_matches")
coll_dir <- here("0.1_descriptives/rel_count_decade/input")  # Define the coll_dir variable

# Initialize data frame to store counts and differences
file_info <- data.frame(label = character(0), counts_coll = integer(0), counts_warriner = integer(0), fifference = integer(0))

for (target in targets) {
  for (corpus in c("psych", "cohacoca")) {
    
    # Construct the "coll" file path with the naming convention
    coll_file_path <- file.path(coll_dir, paste0(target, ".combined.coll.repet.", corpus, ".csv"))
    
    # Construct the file path for warriner_matches
    warriner_file_path <- file.path(warriner_dir, paste0(target, ".warriner_matches.", corpus, ".csv"))
    
    # Calculate counts for warriner_matches
    counts_warriner <- if (file.exists(warriner_file_path)) {
      data <- read.csv(warriner_file_path)
      sum_counts_warriner <- sum(data$count)
    } else {
      sum_counts_warriner <- 0
    }
    
    # Calculate counts for coll
    counts_coll <- if (file.exists(coll_file_path)) {
      coll_data <- read.csv(coll_file_path)
      sum_counts_coll <- sum(coll_data$count)
    } else {
      sum_counts_coll <- 0
    }
    
    # Calculate difference
    difference <- sum_counts_coll - sum_counts_warriner
    
    # Calculate % difference
    perc_diff <- ((sum_counts_warriner/sum_counts_coll)*100)
    
    # Extract the label for better file identification
    label <- paste(target, corpus, sep = ".")
    
    # Store file info in data frame
    file_info <- rbind(file_info, data.frame(Label = label, Counts_coll = sum_counts_coll, Counts_warriner = sum_counts_warriner, Difference = difference, perc_diff = perc_diff))
  }
}

# Print the label, counts(coll), counts(warriner), and difference
print(file_info)

# Specify the file path for saving the file_info data frame
output_file_path <- here("0.1_descriptives/rel_count_decade/output", "warriner_matched_diff.csv")

# Save the file_info data frame to a CSV file
write.csv(file_info, file = output_file_path, row.names = FALSE)
