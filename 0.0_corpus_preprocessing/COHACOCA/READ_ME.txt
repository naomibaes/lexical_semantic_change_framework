Note: 
- The input data for these scripts are not provided, but this is the formatting of the data: text ||||| year ||||| journal_name ||||| id
- Before processing the corpus (lemmatising or dependency parsing), it is good to try it out on a test sample that can be created using, e.g., the bash code below in a terminal: 

head -n 10 coha.coca.cleaned2.noacad.mental.contexts > coha.coca.cleaned2.noacad.mental.contexts.test

Final scripts are altered to use batch processing for efficient preprocessing of large files:

Benefits of Batch Processing:
    Batch Processing: Scripts process the input file in batches. It reads a chunk of lines (defined by batch_size) at a time, normalizes the abstracts for each line in the chunk, 
    and then writes all the processed lines together to the output file.

    Efficiency: Processing data in batches can be more efficient, especially for large files. It reduces the number of times the script needs to open and close the file.
    Memory Management: Reading a large file line by line can lead to memory issues. Batch processing helps manage memory usage by reading smaller chunks at a time.