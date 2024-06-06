corpus1 = "/data/projects/punim0322/COHACOCA/COHA/coha.csv"
corpus2 = "/data/projects/punim0322/COHACOCA/COCA/coca.csv"
merged_corpus = "coha.coca.csv"
processed_corpus = "coha.coca.cleaned"

# Concatenate the two corpus files
with open(corpus1, 'r') as file1, open(corpus2, 'r') as file2, open(merged_corpus, 'w') as merged_file:
    merged_file.write(file1.read())
    merged_file.write(file2.read())
