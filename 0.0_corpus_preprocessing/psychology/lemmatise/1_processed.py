import sys
import re
import spacy
import codecs

nlp = spacy.load('en_core_web_lg')

def normalize_string(text):
    doc = nlp(text)
    tokens = [token.text.lower() for token in doc if token.pos_ not in ['PUNCT', 'SYM', 'PART', 'SPACE']]
    return ' '.join(tokens)

input_file = sys.argv[1]
output_file = f"{input_file}.lc.nopunct"

with codecs.open(input_file, 'r', encoding="utf-8") as reader, codecs.open(output_file, 'w', encoding="utf-8") as writer:
    writer.write(reader.readline())  # Skip the header

    for line in reader:
        parts = re.split(r' \|\|\|\|\| ', line)
        sentence = normalize_string(parts[0])
        writer.write(f"{sentence} ||||| {' ||||| '.join(parts[1:])}")

## input: lemmatized/tokenized file with abstracts
## e.g. abstract ||||| publication_year ||||| journal_title_old ||||| journal_title
#withdrawal response land snail helix albolabris disappear appropriate repetition mechanical stimulus usual terminology snail habituated stimulus disappearance response fatigue term usually understand single stimulus sufficient effect intense stimulation condition quantitatively ascertain remove habituation fact difficult reconcile ordinary conception fatigue c case observe habituation longer - effect extraneous stimulus habituation disappear appropriate rest deepen stimulation response cease hypothesis forward physiological state process tend diminish action process intensify appropriate repetition exist stimulus diminish appropriate rest extraneous stimulation similar hypothesis explain extinction condition response Pavlov underlying process Inhibition phenomenon investigate extinction condition reflex probably explanation reference phenomenon habituation snail biological system behave manner expect system obey Le Chatelier rule ||||| 1930 ||||| Psychologische Forschung ||||| Psychological Research
