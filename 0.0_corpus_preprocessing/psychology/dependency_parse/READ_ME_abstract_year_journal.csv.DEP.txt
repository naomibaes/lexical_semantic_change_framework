Dependency parsing (using spacy transformer model) needs to be done on the raw-est version of the corpus. Including punctuation, numbers etc can increase accuracy.

Here, that is: abstract_year_journal.csv

Year range: 1930--2019
Abstracts: 825628

///

This script reads a text file, applies spaCy's transformer-based English model for dependency parsing to each sentence, and writes the results to a new file. It tokenizes each sentence, extracting lemmas, part-of-speech tags, dependency relations, and head words for each token. The processed information is written alongside the original data with a delimiter " ||||| ". The script is designed to be run from the command line, taking the input file path as an argument and creating a new file with the extension ".DEP" for the output.
