#!/bin/bash

# Author: Naomi Baes, Chat GPT, Ekaterina Vylomova
# Aim: The script extracts and counts unique occurrences of adjective modifiers for each specified term and year from both COHACOCA and Psychology datasets

# Input files
input_file_cohacoca="C:/Users/naomi/OneDrive/COMP80004_PhDResearch/RESEARCH/DATA/CORPORA/COHACOCA/coha.coca.cleaned2.lc.no-numb.noacad.mental.contexts.DEP"
input_file_psych="C:/Users/naomi/OneDrive/COMP80004_PhDResearch/RESEARCH/DATA/CORPORA/Psychology/abstract_year_journal.csv.mental.DEP"

# Search terms to find adjective modifiers for
search_terms="mental_health|mental_illness|perception"

# Output directory
output_dir="input"

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop through each search term
for term in $(echo "$search_terms" | tr "|" "\n"); do
  # Simplify the term names for output file names
  if [[ "$term" == "mental_health" ]]; then
    simple_term="health"
  elif [[ "$term" == "mental_illness" ]]; then
    simple_term="illness"
  else
    simple_term="$term"
  fi

  # Create the term-specific output file for COHACOCA
  term_output_file_cohacoca="${output_dir}/amod.${simple_term}.year.count.cohacoca.csv"
  
  # Remove the term-specific output file if it already exists
  rm -f "$term_output_file_cohacoca"
  
  # Print the header to the term-specific output file for COHACOCA
  echo "year,word,count,term" > "$term_output_file_cohacoca"
  
  # Create the term-specific output file for PSYCH
  term_output_file_psych="${output_dir}/amod.${simple_term}.year.count.psych.csv"
  
  # Remove the term-specific output file if it already exists
  rm -f "$term_output_file_psych"
  
  # Print the header to the term-specific output file for PSYCH
  echo "year,word,count,term" > "$term_output_file_psych"
  
  # Loop through each year from 1970 to 2016 for cohacoca
  for year in $(seq 1970 2016); do
    # Extract collocates and their year of appearance for cohacoca
    cat "$input_file_cohacoca" | grep -P " \|\|\|\|\| $year \|\|\|\|\| " | grep -oP "[[:alpha:]]+:ADJ:amod:${term}" |
    # Perform text cleanup and analysis for cohacoca
    sed -r 's/:[^:]*:amod://g; s/'"$term"'//g' |  # Remove unnecessary information from the word field and the specified term
    sort -d |  # Sort the lines in dictionary order
    uniq -c |  # Count unique lines
    sed -r 's/^ +//g' |  # Remove leading spaces
    sort -k1 -t' ' -n -r |  # Sort by count in descending order
    awk -v year="$year" -v term="$simple_term" -v OFS=',' '{ print year, $2, $1, term }' >> "$term_output_file_cohacoca"
  done

  # Loop through each year from 1970 to 2016 for psych
  for year in $(seq 1970 2016); do
    # Extract collocates and their year of appearance for psych
    cat "$input_file_psych" | grep -P " \|\|\|\|\| $year \|\|\|\|\| " | grep -oP "[[:alpha:]]+:ADJ:amod:${term}" |
    # Perform text cleanup and analysis for psych
    sed -r 's/:[^:]*:amod://g; s/'"$term"'//g' |  # Remove unnecessary information from the word field and the specified term
    sort -d |  # Sort the lines in dictionary order
    uniq -c |  # Count unique lines
    sed -r 's/^ +//g' |  # Remove leading spaces
    sort -k1 -t' ' -n -r |  # Sort by count in descending order
    awk -v year="$year" -v term="$simple_term" -v OFS=',' '{ print year, $2, $1, term }' >> "$term_output_file_psych"
  done
done
