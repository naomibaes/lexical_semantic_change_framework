delimiter = '|||||'
targets = ['mental health', 'mental illness', 'perception']

with open('coha.coca.cleaned2.noacad', 'r', encoding='utf-8') as file, open('coha.coca.cleaned2.noacad.contexts.mental.perception', 'w', encoding='utf-8') as output_file:
  processed_lines = []
  for line_number, line in enumerate(file, start=1):
    # Split the line based on the delimiter
    columns = line.split(delimiter)

    # Check for improper alignment (not 4 columns)
    if len(columns) != 4:
      print(f"Warning: Line {line_number} skipped due to improper alignment: {line.strip()}")
      continue  # Skip to the next line

    # Process the line further (target word check and output)
    first_column = columns[0].strip().lower()
    if any(target in first_column for target in targets):
      processed_lines.append(line.rstrip() + "\n")

  # Write filtered and modified lines to the output file
  output_file.writelines(processed_lines)