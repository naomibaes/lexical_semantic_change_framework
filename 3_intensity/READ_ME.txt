3.1 = arousal index
- Method requires lemmatized corpus
- Data requires extracted collocates (+ year & count statistics) 
	- $term.combined.coll.repet.$corpus

3.2 = intensity index
- Method requires dependency parsed corpus
- Data requires extracted adjective modifiers (+ year & count statistics) 
	- amod.$term.year.count.$corpus

Note:
- output/amod.rel_count contains ranked files for highest relative adjective modifiers of target terms (descriptives)
- output/intensity/index contains combined file for intensity indices
