#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=0-01:00:00
#SBATCH --partition=bigmem
#SBATCH --mem=20G
#SBATCH --output /data/projects/punim0322/COHACOCA/4.2_replace_bigrams.out

# Load required modules
module purge #start with clean env
module load foss/2022a # load a software env including a collection of Free and Open Source Software (FOSS) packages and libraries
module load Python/3.10.4 # load a specific version of Python, making the version available for use in the current session
source ~/venvs/venv-3.10.4/bin/activate # activate a Python virtual environment locates at the path, isolating the Python env and ensuring that any Python packages and dependencies used in this env are separate from the system-wide Python installation and any other virtual environments

# Launch your Python script
echo "Replace bigrams - mental"
python 4.2_replace_bigrams.py

# Deactivate the virtual environment (if you activated one)
deactivate