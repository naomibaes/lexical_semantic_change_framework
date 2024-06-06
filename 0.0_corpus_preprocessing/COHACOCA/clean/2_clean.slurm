#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=0-12:00:00
#SBATCH --partition=cascade
#SBATCH --mem=18G
#SBATCH --output /data/projects/punim0322/COHACOCA/2_clean.out

python 2_clean.py

