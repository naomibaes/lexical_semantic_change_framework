#!/bin/bash

# Author: Naomi Baes, Chat GPT, Ekaterina Vylomova
# Aim: Extract relative frequencies for targets

targets=("mental_health" "mental_illness" "perception")

# Define input files
input_file1="C:\\Users\\naomi\\OneDrive\\COMP80004_PhDResearch\\RESEARCH\\DATA\\CORPORA\\Psychology\\abstract_year_journal.csv.mental"
input_file2="C:\\Users\\naomi\\OneDrive\\COMP80004_PhDResearch\\RESEARCH\\DATA\\CORPORA\\COHACOCA\\coha.coca.cleaned2.lc.no-numb.noacad.mental"

# Define output files with corpus information
output_file_psych="input/targets.year.freq.psych.csv"
output_file_cohacoca="input/targets.year.freq.cohacoca.csv"

# Function to process a single file
function process_file() {
  local input_file="$1"
  local target="$2"
  local corpus="$3"
  local output_file="$4"

  # Loop through years
  for digit in $(seq 1970 2016); do
    target_freq=$(grep -P " \|\|\|\|\| $digit" "$input_file" | awk -F ' \\|\\|\\|\\|\\| ' '{print tolower($1)}' | grep -oP "( |^)$target( |$)" | wc -l)
    echo "$target,$digit,$target_freq,$corpus"
  done >> "$output_file"
}

# Print header row for both output files
echo "target,year,target_freq,corpus" > "$output_file_psych"
echo "target,year,target_freq,corpus" > "$output_file_cohacoca"

# Loop through each target word
for target in "${targets[@]}"; do
  # Process file1 (Psychology)
  corpus="psych"
  process_file "$input_file1" "$target" "$corpus" "$output_file_psych"

  # Process file2 (COHACOCA)
  corpus="cohacoca"
  process_file "$input_file2" "$target" "$corpus" "$output_file_cohacoca"
done

# Replace target values in the output files
sed -i 's/mental_health/health/g' "$output_file_psych"
sed -i 's/mental_illness/illness/g' "$output_file_psych"
sed -i 's/mental_health/health/g' "$output_file_cohacoca"
sed -i 's/mental_illness/illness/g' "$output_file_cohacoca"
