#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=0-12:00:00
#SBATCH --partition=physical
#SBATCH --mem=18G
#SBATCH --output /data/projects/punim0322/Processed/1_processed_slurm

# Load required modules
module --ignore-cache load gcc/8.3.0
module --ignore-cache load "python/2.7.16"

# Launch multiple process python code
echo "Lemmatize (and remove punct + lowercase)"
python 1_processed.py abstract_year_journal.csv
