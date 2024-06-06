import os
import re
import string
import concurrent.futures

# Define a function to perform text cleaning (same as before)
def clean_text(text):
    unwanted_patterns = r'(\( STAR \)|<p>|<P>|<>|@|&c?;|q!|\|p130|NUL|//|--|\*|PHOTO \( COLOR \)|ILLUSTRATION|/)'
    text = re.sub(unwanted_patterns, ' ', text)
    text = text.strip()
    text = re.sub(r'\s+', ' ', text)
    return text

# Function to process a single line
def process_line(line):
    parts = line.strip().split(' ||||| ')
    
    # Check if the first column (text) is empty or contains only whitespace characters
    if not parts[0].strip():
        return None

    # Check the number of parts first to avoid unnecessary processing
    if len(parts) != 4:
        return None
    text, year, _, category = parts
    
    # ensure to remove unwanted categories (blog and web)
    if category in ('blog', 'web'):
        return None
    try:
        year = int(year)
        if 1810 <= year <= 2019:
            cleaned_text = clean_text(text)
            return f'{cleaned_text} ||||| {year} ||||| {parts[2]} ||||| {category}\n'
        else:
            # Skip lines with years outside the range
            return None
    except ValueError:
        # Skip lines with invalid year values
        return None

# Input and output file paths
input_file = '/data/projects/punim0322/COHACOCA/coha.coca'
output_file = '/data/projects/punim0322/COHACOCA/coha.coca.cleaned'

# Create a ThreadPoolExecutor with a specified number of worker threads
# Adjust the max_workers parameter based on your system's capabilities
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as executor:
    with open(input_file, 'r', encoding='utf-8') as merged_file, open(output_file, 'w', encoding='utf-8') as cleaned_file:
        # Use executor.map to process lines in parallel and write results to the output file
        cleaned_lines = executor.map(process_line, merged_file)
        for result in cleaned_lines:
            if result:
                cleaned_file.write(result)

