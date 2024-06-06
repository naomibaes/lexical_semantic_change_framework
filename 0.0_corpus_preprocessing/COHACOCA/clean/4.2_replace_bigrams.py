# Read the content of the file into a list of lines
with open('coha.coca.cleaned2.noacad.contexts.mental.perception', 'r', encoding='utf-8') as file:
    lines = file.readlines()

# Define the multi-character delimiter
delimiter = 'IIIII'

# Process each line: replace specific phrases in the first 'text' column and join back
processed_lines = []
for line in lines:
    parts = line.split(delimiter)
    text_column = parts[0]

    # Replace specific phrases in the first 'text' column
    text_column = text_column.replace('mental health', 'mental_health')
    text_column = text_column.replace('mental illness', 'mental_illness')

    # Join the modified 'text' column with other parts
    parts[0] = text_column
    processed_line = delimiter.join(parts)
    processed_lines.append(processed_line)

# Write the processed lines to a new file
with open('coha.coca.cleaned2.noacad.contexts.mental.perception_', 'w', encoding='utf-8') as output_file:
    output_file.writelines(processed_lines)