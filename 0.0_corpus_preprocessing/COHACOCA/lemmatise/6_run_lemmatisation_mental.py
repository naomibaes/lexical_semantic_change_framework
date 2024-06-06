from __future__ import unicode_literals
import sys
import os

import spacy
import nltk

nltk.download('punkt')  # Download the punkt tokenizer

nlp = spacy.load('en_core_web_trf')
from spacy.lang.en.stop_words import STOP_WORDS

STOP_WORDS.update(['%', 'em', "<", ">", "β", "à", "×", '+', '@'])

print('Spacy and libraries successfully loaded!')

nlp.max_length = 4000000
MAX_TOKENS_THRESHOLD = 512  # Set your desired threshold
MAX_CHARACTERS_THRESHOLD = 4000  # Set your desired character threshold


def process_long_sentence(sentence, nlp, stop_words, max_tokens_threshold):
    tokens = list(nlp(sentence))

    if len(tokens) > max_tokens_threshold:
        tokens = tokens[:max_tokens_threshold]  # Truncate the sentence

    normalized_tokens = []
    for token in tokens:
        if token.pos_ in ['PUNCT', 'SYM', 'PART', 'SPACE', 'NUM']:
            continue
        if token.text.lower() in ['mental_illness', 'mental_health']:
            normalized_tokens.append(token.text.lower())
        else:
            normalized_tokens.append(token.lemma_)
        if token.text.lower() == "-PRON-":
            continue
        if token.text in stop_words:
            continue
    return ' '.join(normalized_tokens)


def normalize_chunk(chunk, nlp, stop_words, max_tokens_threshold, max_characters_threshold):
    processed_lines = []
    for line in chunk:
        abstract, year, article_type, article_id = line.strip().split(' ||||| ')
        normalized_abstract = process_long_sentence(abstract, nlp=nlp, stop_words=stop_words,
                                                     max_tokens_threshold=max_tokens_threshold)
        processed_lines.append(f'{normalized_abstract} ||||| {year} ||||| {article_type} ||||| {article_id}\n')
    return processed_lines


def main():
    if len(sys.argv) < 2:
        print("Usage: python script.py input_file.txt")
        return

    input_file = sys.argv[1]
    output_file = input_file + ".lemmatised"

    # Remove the existing output file
    if os.path.exists(output_file):
        os.remove(output_file)

    batch_size = 1000  # Adjust the batch size as needed

    # Read the input file in batches and process them
    with open(input_file, 'r', encoding='utf-8') as file:
        while True:
            lines = file.readlines(batch_size)
            if not lines:
                break
            processed_lines = normalize_chunk(lines, nlp=nlp, stop_words=STOP_WORDS,
                                              max_tokens_threshold=MAX_TOKENS_THRESHOLD,
                                              max_characters_threshold=MAX_CHARACTERS_THRESHOLD)

            # Write processed lines to the output file
            with open(output_file, 'a', encoding='utf-8') as writer:
                writer.writelines(processed_lines)

    print(f"Processing complete. Results written to {output_file}")


if __name__ == "__main__":
    main()
