#!/bin/bash

# Author: Naomi Baes, Chat GPT, Ekaterina Vylomova
# Aim: Extract relative frequencies for targets

targets=("mental_health" "mental_illness" "perception")

# Create the output folder if it doesn't exist
output_folder="output"
if [ ! -d "$output_folder" ]; then
  mkdir "$output_folder"
fi

# Define input files
input_file1="C:\\Users\\naomi\\OneDrive\\COMP80004_PhDResearch\\RESEARCH\\DATA\\CORPORA\\Psychology\\abstract_year_journal.csv.mental"
input_file2="C:\\Users\\naomi\\OneDrive\\COMP80004_PhDResearch\\RESEARCH\\DATA\\CORPORA\\COHACOCA\\coha.coca.cleaned2.lc.no-numb.noacad.mental"

# Define output file with corpus information
output_file="output/targets.year.ntf.csv"

# Function to process a single file
function process_file() {
  local input_file="$1" local target="$2" local corpus="$3"

  # Loop through years
  for digit in $(seq 1970 2016); do
    total=$(grep -P " \|\|\|\|\| $digit" "$input_file" | awk -F ' \\|\\|\\|\\|\\| ' '{print $1}' | wc -w)
    target_freq=$(grep -P " \|\|\|\|\| $digit" "$input_file" | awk -F ' \\|\\|\\|\\|\\| ' '{print tolower($1)}' | grep -oP "( |^)$target( |$)" | wc -l)
    ntf=$(perl -e "printf '%.9f', ($foc_freq/$total)")
    echo "$target,$digit,$total,$foc_freq,$ntf,$corpus"
  done
}

# Print header row
echo "target,year,total,foc_freq,ntf,corpus" > "$output_file"

# Loop through each target word
for target in "${targets[@]}"; do
  # Process file1 (Psychology)
  corpus="Psychology"
  process_file "$input_file1" "$target" "$corpus" >> "$output_file"

  # Process file2 (COHACOCA)
  corpus="General"
  process_file "$input_file2" "$target" "$corpus" >> "$output_file"
done


