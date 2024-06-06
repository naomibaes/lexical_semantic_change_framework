#!/bin/bash

# Naomi Baes, Chat GPT, Ekaterina Vylomova
# Aim: This script processes words for specified terms across different corpora, extracting contextual information, performing text cleanup and analysis, and saving the results into CSV files.

# Function to process a single word and corpus
function process_word() {
  local word="$1"
  local corpus="$2"

  # Define input file paths for each corpus
  local cohacoca_file="C:/Users/naomi/OneDrive/COMP80004_PhDResearch/RESEARCH/DATA/CORPORA/COHACOCA/coha.coca.cleaned2.lc.no-numb.noacad.mental.contexts.processed.en_core_web_trf"
  local psych_file="C:/Users/naomi/OneDrive/COMP80004_PhDResearch/RESEARCH/DATA/CORPORA/Psychology/abstract_year_journal.csv.processed.lc.no-numb.mental"

  # Process the input file based on corpus
  if [ "$corpus" == "cohacoca" ]; then
    input_file="$cohacoca_file"
  elif [ "$corpus" == "psych" ]; then
    input_file="$psych_file"
  else
    echo "Error: Invalid corpus name '$corpus'."
    exit 1
  fi

  input_dir="input"  # Correctly define input_dir

  # Create the context folder if it doesn't exist
  if [ ! -d "$input_dir/context" ]; then
    mkdir -p "$input_dir/context"
  fi

  # Create the input and output directories if they don't exist
  mkdir -p "$input_dir/context" "$output_dir"
  
  # Extract the part of the word after the underscore (for naming)
  processed_word=$(echo $word | cut -d '_' -f 2)

  # Process the input file
  cat "$input_file" | awk -F' \\|\\|\\|\\|\\| ' '{print tolower($1)" ||||| "$2}' | grep -P " $word " > "$input_dir/context/$processed_word.context.$corpus"

  # Combine all year statistics into a single file
  local combined_stats_file="$input_dir/$processed_word.combined.coll.repet.$corpus.csv"
  echo "year,word,count" > "$combined_stats_file"

  # Loop through years from 1970 to 2016
  for digit in $(seq 1970 2016); do
    # Filter lines containing the current year, extract context
    cat "$input_dir/context/$processed_word.context.$corpus" |
      grep -P ' \|\|\|\|\| '$digit'' |
      grep -oPh "(\w+ ){0,5}$word( \w+){0,5}" > "$input_dir/context/$processed_word.$digit.context.$corpus"

    # Create a file to store the context for the current year
    local context_year_file="$input_dir/context/$processed_word.$digit.contexts.$corpus.txt"

    # Save the contexts for each year
    cat "$input_dir/context/$processed_word.$digit.context.$corpus" >> "$context_year_file"

    # Perform text cleanup and analysis
    cat "$input_dir/context/$processed_word.$digit.context.$corpus" |
      sed -r 's/ +/ /g;s/ /\n/g' |  # Collapse spaces, split into lines
      grep -v -E '^[0-9]+$' |      # Remove rows that consist solely of numerals
      sed -r 's/\<'"$word"'\>//g' |  # Remove the center word
      grep -v -E '^.{0,1}$' |      # Remove empty rows and one-letter words
      sort -d |                    # Sort the lines in dictionary order
      uniq -c |                    # Count unique lines
      sed -r 's/^ +//g' |          # Remove leading spaces
      sort -k1 -t' ' -n -r > "$input_dir/context/$processed_word.$digit.coll.repet.$corpus"  # Save intermediate result

    # Append statistics for the current year to the combined file
    awk -v year="$digit" '{ word = $2; count = $1; $1 = ""; $2 = ""; print year","word","count}' "$input_dir/context/$processed_word.$digit.coll.repet.$corpus" >> "$combined_stats_file"

    # Remove temporary files after processing
    rm "$input_dir/context/$processed_word.$digit.context.$corpus"
    rm "$input_dir/context/$processed_word.$digit.coll.repet.$corpus"
  done
}

# List of terms for processing
targets="mental_health mental_illness perception"

# Process each term for both corpora
for target in $targets; do
  process_word "$target" "cohacoca"
  process_word "$target" "psych"
done

