#!/bin/bash
#SBATCH --job-name=4.0_remove_acad.sh
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1:00:00
#SBATCH --output=4.0_remove_acad_output.log
#SBATCH --error=4.0_remove_acad_error.log

# Execute your script
bash 4.0_remove_acad.sh
~                        