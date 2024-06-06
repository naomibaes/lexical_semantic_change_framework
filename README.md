# Lexical Semantic Change Evaluation Framework

This repository contains the source code for evaluating dimensions of lexical semantic change concurrently, as outlined in the companion manuscript titled "A Multidimensional Framework for Evaluating Lexical Semantic Change with Social Science Applications" by Naomi Baes, Nick Haslam, and Ekaterina Vylomova.

## About

The Lexical Semantic Change Evaluation Framework assesses lexical semantic change across various dimensions and supports analysis in Bash, Python, and R. Each dimension has its own folder.

### Languages and Environments

Programming Languages: 

- **Bash**: Shell scripts (.sh)
- **Python**: Scripts (.py) and Jupyter Notebooks (.ipynb)
- **R**: Scripts (.R)

Environments:

- **Spartan**: The University of Melbourne’s high-performance computing system for preprocessing corpus data (transformer models).
    - **Related Scripts**: Slurm files for HPC clusters (job scheduler and workload manager).
- **Visual Studio Code IDE**: Integrated environment for running scripts with Conda environment management for Python and renv for R.

## License

- The code is licensed under the Creative Commons Attribution 4.0 International Public License (CC BY 4.0), allowing others to share and adapt the work with appropriate credit.
- The Association for Computational Linguistics (ACL) is the licensor of the code: "*Copyright © 2020 Association for Computational Linguists (ACL). All Rights Reserved.*"

### Citation Request

If you use this code in your research or project, please cite the following paper:

- **Title**: A Multidimensional Framework for Evaluating Lexical Semantic Change with Social Science Applications
- **Authors**: Naomi Baes, Nick Haslam, Ekaterina Vylomova
- **Conference**: Proceedings of the Association for Computational Linguistics (ACL), 2024

## Additional Information

- Corpus data are not provided due to copyright restrictions, but the format is: "text ||||| year ||||| publication_type ||||| id".
- The `environment.txt` file provides links to download R environment and Python dependencies for reproducibility.
- For an applied example of the framework, refer to the [OSF repository](https://osf.io/4d7ur/). It contains scripts for statistical analysis and programming figures.
- The code may be updated (streamlined and new methods for evaluating the dimensions may be added).

For questions, contact Naomi Baes at naomi_baes@hotmail.com.
