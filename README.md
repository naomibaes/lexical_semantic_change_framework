# Repository Description

This repository contains the source code to evaluate dimensions of lexical semantic change concurrently, as specified by the computational framework outlined in the companion manuscript titled "A Multidimensional Framework for Evaluating Lexical Semantic Change with Social Science Applications” by Naomi Baes, Nick Haslam, and Ekaterina Vylomova.

## Programming Languages (across scripts)

    Bash (Bourne Again Shell) (.sh)
    Python (version 3.11.9) (.py, .ipynb)
    R (version 4.2.2) (.R)

**Programming Environments**

    Spartan : the University of Melbourne’s general purpose hybrid high performance computing system (Lafayette et al., 2016) used to preprocess the corpus data (all scripts in the 0_corpus_preprocessing folder).
        Usage:
            Vim Editor (code editor)
            Slurm (Job scheduler and workload manager for HPC clusters - submit ".slurm" files)
        Reference: Lafayette, L., Sauter, G., Vu, L., & Meade, B. (2016). Spartan performance and flexibility: An hpc-cloud chimera. OpenStack Summit, Barcelona, 27.
    IDE - Visual Studio Code: for integrated workflow to run scripts
        Python Setup
            .conda environment management
        R Setup
            renv for consistent and isolated environments for each project (ensuring consistent package versions across different machines or user accounts).
                New Project? Initialize renv: renv::init()
                Ensure renv is installed: install.packages("renv")
                Activate the environment: renv::restore()

*Note:* 
- The environment folder provides a link to download the R environment and Python dependencies needed to work within a reproducible environment, ensuring consistency across different machines.
- Corpora for input data are not provided as data are copyrighted and not publicly available, however examples of the corpus format are given for preprocessing examples.
- Necessary additional folders should be created dynamically upon running scripts.
- See the following repository for an applied example of the framework on mental_health, mental_illness, and perception: https://osf.io/4d7ur/
	- This OSF repository contains a folder for programming figures (6_fig) and running statistical analyses (7_statistical_analyses) which are not included here.

## Copyright and Licensing Information

**Code License:**

    The code associated with this work is licensed under the Creative Commons Attribution 4.0 International Public License. This allows others to share and adapt the work, provided appropriate credit is given, a link to the license is provided, and any changes are indicated.

**Licensor:**

    The Association for Computational Linguistics (ACL) is the licensor of the code. The appropriate copyright notice to use is: "Copyright © 2020 Association for Computational Linguistics (ACL). All Rights Reserved."

**Creative Commons Attribution 4.0 International Public License:**

    You can view the full terms of the Creative Commons Attribution 4.0 International Public License here: https://creativecommons.org/licenses/by/4.0/.

**Citation Request:**

    If you use this code in your research or project, please cite the following paper:

    A Multidimensional Framework for Evaluating Lexical Semantic Change with Social Science Applications
    Naomi Baes, Nick Haslam, Ekaterina Vylomova
    Proceedings of the Association for Computational Linguistics (ACL), 2024
    [DOI or URL of the Paper]


-----------------------------------------------

Contact me at naomi_baes@hotmail.com if you have any questions.
