# Define the row IDs and values to be deleted
row_ids_to_delete = {27865, 56890, 133704, 133712, 133731, 134701, 135013, 185605, 192085, 200098, 214648, 232026, 239687, 267122, 296240, 296714, 303621, 305802, 306464, 307195, 319071, 319074, 319076, 319078, 319082, 319177, 319179, 319180, 319181, 319182, 319371, 319565, 319674, 320170, 320535, 320559, 344322, 344687, 346139, 346364, 357439}
values_to_delete = {'1013862', '2009789', '2017911', '3049557', '3054052', '3071942', '3072468', '3072477', '3072481', '3073291', '3073359', '4024219', '4084001', '4123078', '4124585', '4129342', '4129982', '4132205', '4133409', '4133516', '4134836', '4137394', '4145315', '4146668', '4146669', '4148615', '4188609', '4198419', '5015911', '5016643', '5220342'}

# Define the input and output file paths
input_file = "coha.coca.cleaned"
output_file = "coha.coca.cleaned2"

# Open the input file for reading and the output file for writing
with open(input_file, 'r', encoding='utf-8') as input_file, open(output_file, 'w', encoding='utf-8') as output_file:
    line_count = 0
    skipped_lines = 0
    processed_lines = 0  # To keep track of lines with correct delimiters

    # Loop through each line in the input file
    for line in input_file:
        line_count += 1

        # Split the line into parts using ' ||||| ' as the delimiter
        parts = line.strip().split(' ||||| ')

        # Check if the number of parts (columns) is as expected (e.g., 4 for your data)
        if len(parts) != 4:
            continue  # Skip lines with inconsistent delimiters

        # Extract the necessary information
        text, year, _, category = parts

        # Process the line further as needed
        # Example: Print the text and category
        print(f"Text: {text}, Category: {category}")

        # Check if the current line's row ID is in the set of row IDs to delete or if the value in column 3 is in the set of values to delete
        if line_count not in row_ids_to_delete and category not in values_to_delete:
            output_file.write(line)

            # Check if the line contains the correct number of delimiters
            if line.count(' ||||| ') == 3:
                processed_lines += 1
            else:
                skipped_lines += 1

print(f"{len(row_ids_to_delete)} lines and {len(values_to_delete)} values deleted. Output written to {output_file}")
print(f"Processed {processed_lines} lines with correct delimiters.")
print(f"Skipped {skipped_lines} lines with inconsistent delimiters.")