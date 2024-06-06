import spacy

# Load the spaCy English NLP model
nlp = spacy.load("en_core_web_trf", disable=["ner"], device=-1)  # Disable NER and leverage GPU support (if available)

# Set a higher limit for nlp.max_length
nlp.max_length = 2000000  # Adjust this value as needed

# Input and output file paths
input_file = "coha.coca.cleaned2.noacad.contexts.mental.perception_"
output_file = input_file + ".DEP"

batch_size = 100  # Adjust this value as needed

with open(input_file, "r", encoding="utf-8") as f_in, open(output_file, "w", encoding="utf-8") as f_out:
    lines = f_in.readlines()
    for i in range(0, len(lines), batch_size):
        batch_lines = lines[i:i + batch_size]

        # Process the batch of lines using spaCy
        batch_processed_lines = []
        for line in batch_lines:
            line = line.strip()
            if not line:
                continue  # Skip empty lines

            # Split the line by the delimiter
            columns = line.split("|||||")

            # Only process the first column (text for dependency parsing)
            text_to_parse = columns[0]

            # Process the text using spaCy
            doc = nlp(text_to_parse)

            # Loop through tokens and print information for each token
            tokens = []
            for token in doc:
                tokens.append(f"{token.text}:{token.pos_}:{token.dep_}:{token.head.text}")

            # Combine parsed text with remaining columns
            parsed_line = " ".join(tokens) + " ||||| " + " ||||| ".join(columns[1:])

            # Add the processed line to a list
            batch_processed_lines.append(parsed_line)

        # Write the processed batch lines to the output file
        f_out.write("\n".join(batch_processed_lines) + "\n")

print("Dependency parsing and formatted output completed. Check the output file.")
