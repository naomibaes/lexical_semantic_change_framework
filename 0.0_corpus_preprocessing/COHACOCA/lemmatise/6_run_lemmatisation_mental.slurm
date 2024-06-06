#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=10-00:00:00
#SBATCH --partition=bigmem
#SBATCH --mem=40G
#SBATCH --output /data/projects/punim0322/COHACOCA/6_run_dependency_mental.out
#SBATCH --mail-user=n.baes@unimelb.edu.au

# Navigate to your project directory
cd /data/projects/punim0322/COHACOCA

# Activate the virtual environment (create one if not exists)
if [ ! -d "venv" ]; then
    python -m venv venv
fi
source venv/bin/activate

# Upgrade pip
python -m pip install --upgrade pip

# Install spacy, nltk, and pandas in the virtual environment
python -m pip install spacy nltk pandas

# Download spaCy model
python -m spacy download en_core_web_trf

# Download NLTK data
python -m nltk.downloader punkt

# Launch your Python script
echo "Lemmatize and more (tokenizing, lemmatizing, normalizing, and removing punctuation, stopwords and symbols)"
python 6_run_lemmatisation_mental.py coha.coca.cleaned2.noacad.contexts.mental.perception_

# Deactivate the virtual environment
deactivate
