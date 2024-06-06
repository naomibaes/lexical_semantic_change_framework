
Aim: These steps preprocess the corpus for the various corpus versions
Corpus format: text ||||| year ||||| article_type ||||| article_id
______________________________________________________________________

1) merge coha and coca                                                     1_merge_coha.coca.py results in coha.coca (coha + coca merged horizontally)
2) clean according to Alatrash et al. (2020)                               2_clean.py
3) remove lines (column mis-alignments and more)                           3_coha.coca.cleaned_lines_wrong_col.py
4.0) remove academic texts (so as to keep a corpus that has them too)      4.0_remove.acad.sh
4.1) only keep lines with target terms (optional to speed up the process)  4.1_get_contexts_mental.perception.py
4.2) replace bigrams with unigrams (mental illness = mental_illness)            4.2_replace_bigrams.py
    final corpus file name: coha.coca.cleaned2.noacad.contexts.mental.perception_

Then carry out preprocessing
7) lemmatise                                                               6_run_lemmatiation_mental.py
    final corpus file name: coha.coca.cleaned2.noacad.contexts.mental.perception_.lemmatised

8) dependency parse the corpus                                             6_run_dependency_mental.py
    final corpus file name: coha.coca.cleaned2.noacad.contexts.mental.perception_.DEP

Note: This is an optional step to ensure that grep captures all target terms and counts words accurately, an extra version of the corpus was created for extracting relative frequencies (it begins from step 3)

4) remove numbers, punctuation, lower-captures                              4_remove_numbers.punct.lc.py
4.2) replace bigrams with unigrams (mental illness = mental_illness)        4.2_replace_bigrams.py          note: re-use the script above and alter the file names

    final corpus file name: coha.coca.cleaned2.noacad.no-numb.no-punct.lc_
