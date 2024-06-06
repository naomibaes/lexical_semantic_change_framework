#!/bin/bash

input_file="coha.coca.cleaned2"
output_file="coha.coca.cleaned2.noacad"

awk -F ' \\|\\|\\|\\|\\| ' '$3 != "acad"' "$input_file" > "$output_file"

echo "Filtered data written to $output_file"
