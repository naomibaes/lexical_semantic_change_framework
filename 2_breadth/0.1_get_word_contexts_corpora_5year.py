# Author: Naomi Baes and Chat GPT
# Purpose: This script uses lines containing specific target terms related to mental health to generate up to 50 random sentences 10 stimes from target_term filtered lines for further analysis.
# Output example for generate_interval_samples():
    # mental_illness.sentences.psych.1970-1974.1; [...].2, etc.
# To launch the code, run: python [file_name]

import re
import os
import random

def generate_samples(input_file, class_name, corpus):
    output_dir = f"output/5-year.cosine.BERT"
    context_file = f"{class_name}.context.{corpus}"
    pattern_year = re.compile(r'\|\|\|\| (\d{4}) \|\|\|\|')
    pattern_mental = re.compile(r'([^.]*?\b' + re.escape(class_name) + r'\b[^.]*\.)')
    # Read input file and filter relevant lines
    with open(input_file, "r") as file:
        filtered_lines = [line.strip() for line in file if re.search(r'\b(mental_health|mental_illnesses?)\b', line, re.IGNORECASE)]
    # Write filtered lines to output context file
    with open(f"{output_dir}/{context_file}", "w") as output_file:
        output_file.write("\n".join(filtered_lines))
    # Generate samples for each 5-year interval
    for interval_start in range(1970, 2020, 5):
        generate_interval_samples(interval_start, filtered_lines, output_dir, class_name, corpus, pattern_year, pattern_mental)

def generate_interval_samples(interval_start, filtered_lines, output_dir, class_name, corpus, pattern_year, pattern_mental):
    for i in range(1, 11):
        samples = []
        for line in filtered_lines:
            match = pattern_year.search(line)
            if match:
                year = int(match.group(1))
                if interval_start <= year < interval_start + 5:
                    match = pattern_mental.search(line)
                    if match:
                        samples.append(match.group(1).strip())
        samples = random.sample(samples, min(50, len(samples)))
        with open(f"{output_dir}/{class_name}.{interval_start}-{interval_start+4}.{corpus}.{i}", "w") as output_file:
            output_file.write("\n".join(samples))

# Generate samples for mental_health for the cohacoca corpus (etc)
generate_samples("/data/projects/punim0322/Processed/abstract_year_journal.csv.mental", "mental_health", "cohacoca")
generate_samples("/data/projects/punim0322/COHACOCA/coha.coca.cleaned2.mental", "mental_illness", "cohacoca")
generate_samples("/data/projects/punim0322/Processed/abstract_year_journal.csv.mental", "mental_health", "psych")
generate_samples("/data/projects/punim0322/Processed/abstract_year_journal.csv.mental", "mental_illness", "psych")

print("Generation completed.")