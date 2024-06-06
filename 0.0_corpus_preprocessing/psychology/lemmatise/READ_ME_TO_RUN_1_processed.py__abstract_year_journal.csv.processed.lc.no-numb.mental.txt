This .py file is tailored to run on a HPC system and therefore creates a virtual environment within the slurm script. However, you can also run it on your remote dektop using the prompts below (or within a system after following the below and removing the creation of the virtual environment):

# In Anaconda Powershell Prompt

#1: Install the required Python packages (e.g., pandas, spacy, numpy) using pip if you haven't already:
pip install pandas spacy numpy

#2: Download the spaCy model using the following command:
python -m spacy download en_core_web_lg

#3: This will download and install the "en_core_web_lg" model using pip. After downloading the model, you can run your script using the Anaconda PowerShell prompt. Navigate to the directory where your script is located and run it:
python your_script_name.py

cd "C:\Users\naomi\OneDrive\PHD\CONFERENCES\workshopcomp_historical_language_change\OSF"

python preprocess_data_spacy.py "C:\Users\naomi\OneDrive\PHD\CONFERENCES\workshopcomp_historical_language_change\OSF\data\input\corpora\coha.coca.processed.all.lc.no-numb.noacad.csv"




