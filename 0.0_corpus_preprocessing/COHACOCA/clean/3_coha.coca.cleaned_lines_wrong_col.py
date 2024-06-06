# Define the input and output file paths
input_file = "/data/projects/punim0322/COHACOCA/coha.coca.cleaned"
output_file = "lines_with_wrong_columns_coha.coca.cleaned.txt"

# Open the input file for reading and the output file for writing
with open(input_file, 'r', encoding='utf-8') as input_file, open(output_file, 'w', encoding='utf-8') as output_file:
    line_count = 0  # Counter to keep track of lines processed
    wrong_column_count = 0  # Counter for lines with the wrong number of columns
    
    # Loop through each line in the input file
    for line in input_file:
        line_count += 1
        
        # Split the line by " ||||| " to separate columns
        columns = line.strip().split(" ||||| ")
        
        # Check if the line doesn't have exactly 4 columns
        if len(columns) != 4:
            wrong_column_count += 1
            # Write the line to the output file
            output_file.write(f"Line {line_count}: {line}")
    
    # Print the summary
    print(f"Total lines with wrong columns: {wrong_column_count}")
    print(f"Total lines processed: {line_count}")

print(f"Lines with wrong columns written to {output_file}")

