Author: Chat GPT & Naomi Baes

Key functionalities of each section in the script:

1. Imports:

    The script imports libraries for various functionalities like file handling (os), system interaction (sys), regular expressions (re), natural language processing (spacy), text processing (numpy, codecs), parallel processing (concurrent.futures), and performance measurement (timeit).

2. spaCy Setup:

    It loads the English language model (en_core_web_lg) from spaCy for dependency parsing.
    It adjusts the max_length property of the spaCy model to handle longer texts (set to 1,200,000 characters in this case).

3. Text Processing Functions:

    process_text: This function takes text input, tokenizes it using spaCy, and extracts information for each token:
        Lemma (base form of the word)
        Part-of-speech (e.g., noun, verb, adjective)
        Dependency relation (relationship of the word to another word in the sentence)
        Head word (the word the current word depends on)
        Original text of the word
        The output is a string with this information separated by colons.

    process_line: This function splits the line by a delimiter (||||| in this case) and checks the length of the first part (text).
        If the length is less than a threshold (e.g., 1,000,000 characters), it:
            Processes the text part using process_text.
            Concatenates the processed text with the remaining parts of the line.

4. Command-Line Argument Handling:

    The script verifies it receives the correct number of command-line arguments (one: the input file path).
    If not, it displays an error message and exits.

5. Input and Output File Paths:

    The input and output file paths are derived from the command-line argument.
    The output file name is created by appending ".DEP" to the input file name.

6. File Processing:

    It opens the input file for reading and the output file for writing.
        Skipping the header line is mentioned as not implemented in this explanation (it is skipped for the psychology corpus, but this input file has no header).

    It utilizes ThreadPoolExecutor to parallelize processing lines from the input file using the process_line function. This improves efficiency on computers with multiple cores.

    The processed lines are written to the output file.

7. Prints Completion Message:

    The script informs the user about successful processing completion and mentions the output file path.

Additional Notes:

    Dependency parsing models thrive on more information like punctuation and capitalization, which is why we included these elements to potentially improve the model's performance.
