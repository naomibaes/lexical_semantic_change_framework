#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=5-00:00:00
#SBATCH --partition=cascade
#SBATCH --mem=18G
#SBATCH --output /data/projects/punim0322/COHACOCA/1_merge_corpora.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=n.baes@unimelb.edu.au

# run .sh script
python 1_merge_coha.coca.py
