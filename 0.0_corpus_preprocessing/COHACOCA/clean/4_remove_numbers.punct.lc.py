import pandas as pd
import csv

# Define the input and output file names
input_filename = 'coha.coca.cleaned2.noacad'
output_filename = 'coha.coca.cleaned2.noacad.no-numb.no-punct.lc'
error_log_filename = 'error_log.txt'

# Define the multi-character delimiter
delimiter = '|||||'

# Open the input file, create the output file, and the error log file
with open(input_filename, 'r', encoding='utf-8') as input_file, \
        open(output_filename, 'w', encoding='utf-8') as output_file, \
        open(error_log_filename, 'w', encoding='utf-8') as error_log:

    # Process each line in the input file
    for line_number, line in enumerate(input_file, start=2):
        try:
            # Split the line into columns using the delimiter
            columns = line.strip().split(delimiter)

            # Check if the line has the expected number of columns
            if len(columns) < 4:
                raise ValueError(f"Expected 4 columns, but found {len(columns)} columns.")

            # Remove numbers and lowercase the 'text' column
            text_column = ''.join(char.lower() if char.isalpha() or char.isspace() else '' for char in columns[0])

            # Write the processed line to the output file
            output_file.write(f"{text_column}{delimiter}{delimiter.join(columns[1:])}\n")

        except Exception as e:
            # Log the line number causing the issue into the error log file
            error_log.write(f"Error processing line {line_number}: {line.strip()} - {str(e)}\n")

# Read the processed data into a DataFrame
df = pd.read_csv(output_filename, sep=delimiter, header=None,
                 names=['text', 'year', 'type', 'id'], engine='python', quoting=csv.QUOTE_NONE)
