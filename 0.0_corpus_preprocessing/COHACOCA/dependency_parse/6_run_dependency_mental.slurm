#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=20-00:00:00
#SBATCH --partition=bigmem
#SBATCH --mem=80G
#SBATCH --output /data/projects/punim0322/COHACOCA/6_run_dependency_mental.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=n.baes@unimelb.edu.au
#SBATCH -p gpu-a100  # Request the gpu-a100 partition
#SBATCH --gres=gpu:1   # Request GPU

# Load required modules
module purge # start with a clean environment
module load foss/2022a # load a software environment including a collection of Free and Open Source Software (FOSS) packages and libraries
module load Python/3.10.4 # load a specific version of Python, making the version available for use in the current session

# Upgrade pip
pip install --upgrade pip

# Install NumPy locally
pip install --user numpy

# Activate Python virtual environment
source ~/venvs/venv-3.10.4/bin/activate

# Install and load the required Python package (scikit-learn) inside the virtual environment
pip install scikit-learn==0.24.2  # Specify the version compatible with your code

# Download the spaCy model if it's not already downloaded
python -m spacy download en_core_web_trf

# Launch your Python script
echo "Apply dependency parser"
python /data/projects/punim0322/COHACOCA/6_run_dependency_mental.py 

# Deactivate the virtual environment
deactivate

# Execute memory tracking script
if [ -f ~/.memory_tracking_script ]; then
    echo "Executing memory tracking script"
    bash ~/.memory_tracking_script2
fi