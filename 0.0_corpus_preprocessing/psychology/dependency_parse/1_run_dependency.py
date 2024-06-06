#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import numpy as np
import sys
import re, spacy, sklearn, codecs

nlp = spacy.load('en_core_web_trf')
from sklearn.feature_extraction.text import CountVectorizer
from spacy.lang.en.stop_words import STOP_WORDS
from timeit import default_timer as timer

## input: lemmatized/tokenized file with abstracts
## e.g. abstract ||||| publication_year ||||| journal_title_old ||||| journal_title
#withdrawal response land snail helix albolabris disappear appropriate repetition mechanical stimulus usual terminology snail habituated stimulus disappearance response fatigue term usually understand single stimulus sufficient effect intense stimulation condition quantitatively ascertain remove habituation fact difficult reconcile ordinary conception fatigue c case observe habituation longer - effect extraneous stimulus habituation disappear appropriate rest deepen stimulation response cease hypothesis forward physiological state process tend diminish action process intensify appropriate repetition exist stimulus diminish appropriate rest extraneous stimulation similar hypothesis explain extinction condition response Pavlov underlying process Inhibition phenomenon investigate extinction condition reflex probably explanation reference phenomenon habituation snail biological system behave manner expect system obey Le Chatelier rule ||||| 1930 ||||| Psychologische Forschung ||||| Psychological Research

reader = codecs.open(sys.argv[1],'r', encoding="utf-8")
writer = codecs.open(sys.argv[1]+".DEP",'w', encoding="utf-8")
writer.write(reader.readline())#skip the headeut=

for line in reader.readlines():
	parts = re.split(r' \|\|\|\|\| ', line)
	sentence = nlp(parts[0])
	out = ''
	for token in sentence:
		out += ':'.join([token.lemma_, token.pos_, token.dep_, token.head.text]) # str([child for child in token.children]))
		out += ' '
	writer.write(out +" ||||| "+" ||||| ".join(parts[1:]))
