# 🟢🔴🔵 SIBling: A Multidimensional Framework for Evaluating Lexical Semantic Change with Social Science Applications

Baes, N., Haslam, N., & Vylomova, E. (2024).  
*A Multidimensional Framework for Evaluating Lexical Semantic Change with Social Science Applications.*  
In *Proceedings of the 62nd Annual Meeting of the Association for Computational Linguistics (ACL 2024)*.  
[📄 ACL Anthology Link](https://aclanthology.org/2024.acl-long.76/)

---

## 📄 About

**SIBling** proposes a unified, psychologically grounded framework for evaluating lexical semantic change (LSC) along three interpretable and quantifiable dimensions:

- **Sentiment**: positive ↔ negative  
- **Intensity**: strong ↔ weak  
- **Breadth**: wide ↔ narrow  

This framework reduces traditional lexical change types (e.g., amelioration, narrowing) into three continuous, empirically testable axes—enabling concurrent evaluation of how word meanings shifts over time.

> 🔁 For the implementation and evaluation of the methods introduced here, see: [LSC-Eval](https://github.com/naomibaes/LSCD_method_evaluation/tree/main)

---

## 🟢 🔴 🔵 Dimensions of Change

| Dimension   | Definition | Rising Example | Falling Example |
|-------------|------------|----------------|-----------------|
| 🟢 **Sentiment** | Change in a word’s evaluative connotation: does it acquire more positive (*elevation*) or negative (*pejoration*) meaning? | *geek* (derogatory → enthusiast) | *retarded* (clinical → pejorative) |
| 🔴 **Intensity** | Shift in emotional force: does the meaning become stronger (*meiosis*) or weaker (*hyperbole*)? | *hilarious* (from cheerful → extreme laughter) | *trauma* (from brain injury → mild adversity) |
| 🔵 **Breadth** | Shift in semantic scope: does the meaning expand (*generalization*) or contract (*specialization*) its semantic range? | *cloud* (weather → internet storage) | *meat* (any food → animal flesh) |

These axes mirror affective and connotational dimensions validated in psychology and semantics (e.g., Valence–Arousal, Evaluation–Potency).

---

## 📁 Repository Structure

| Folder/File                                | Description |
|--------------------------------------------|-------------|
| `0.0_corpus_preprocessing/`                | Scripts for corpus preprocessing (e.g., cleaning, lemmatization, dependency parsing, filtering by target term) |
| `0.1_descriptives/`                        | Scripts to generate descriptive statistics about target term frequencies and distributions |
| `1_sentiment/`                             | Scripts for evaluating Sentiment change (e.g., Valence index using collocates) |
| `2_breadth/`                               | Scripts for measuring semantic Breadth (e.g., sentence-level Breadth score using embedding spread) |
| `3_intensity/`                             | Scripts for detecting Intensity change (e.g., Arousal index and intensifier modifier patterns) |
| `4_salience/`                              | Scripts for calculating relative frequency change or salience of target terms over time |
| `5_thematic_content/pathologization/`      | Scripts for analyzing shifts in thematic content, using a top-down dictionary approach to measure pathologization (in collocates) |
| `environment.txt`                          | Instructions and links for setting up Conda (Python) and renv (R) environments for full reproducibility |
| `README.md`                                | You are here! |

---

## 🧪 Methodological Foundations

SIBling maps six classical types of semantic change (e.g., amelioration, narrowing, hyperbole) to **three semantic dimensions**. This enables:

- **Concurrent quantification** of multiple kinds of change  
- **Greater sensitivity** to subtle, co-occurring shifts in word meaning  
- **Alignment with psychological theories** of concept representation and cultural change  

> See [Figure 1 and Table 1](https://aclanthology.org/2024.acl-long.76) in the ACL 2024 paper for full theoretical mapping.

---

## 🔗 Companion Resources

- [📁 LSC-Eval](https://github.com/naomibaes/LSCD_method_evaluation/tree/main): End-to-end evaluation framework for LSC methods using synthetic change detection benchmarks built on the SIBling framework.  
- [📁 Synthetic-LSC Pipeline](https://github.com/naomibaes/Synthetic-LSC_pipeline): Generation of synthetic corpora with controlled SIB changes using GPT and WordNet.  
- [📁 Psychology Corpus](https://github.com/naomibaes/psychology_corpus): Year-partitioned corpus used in proof-of-concept case studies.

---

## 🛠️ Languages and Environments

**Programming Languages**  
- **Python**: Language evaluation scripts (`*.py`, Jupyter Notebooks)  
- **R**: Mainly statistical analysis and plotting (`*.R`)  
- **Bash**: Shell scripts for preprocessing and job scheduling (`*.sh`)

**Computational Environments**  
- **Spartan (HPC)**: Used for large-scale preprocessing, embedding extraction, and SLURM-based job execution  
- **VS Code / Local IDEs**: Recommended for running Python and R scripts locally, using Conda (Python) and `renv` (R) for reproducibility

---

## 📎 Additional Information

- - **Reproducibility**: The `environment.txt` file contains instructions and a Google Drive link to download the original `.conda/` and `renv/` folders used in the project. These ensure consistent environments for:
  - 🐍 **Python**: via Conda-managed environments
  - 📊 **R**: via `renv`, enabling project-specific library management and reproducibility

> To restore the R environment:
> ```r
> install.packages("renv")
> renv::restore()
> ```
- **Future Updates**: This repository may be expanded to streamline processes or incorporate improved methods for evaluating each semantic dimension.

---

## 📚 Citation

If you use the SIBling framework or its code in your work, please cite the original theoretical paper:

```bibtex
@inproceedings{baes-etal-2024-multidimensional,
    title = "A Multidimensional Framework for Evaluating Lexical Semantic Change with Social Science Applications",
    author = "Baes, Naomi  and
      Haslam, Nick  and
      Vylomova, Ekaterina",
    editor = "Ku, Lun-Wei  and
      Martins, Andre  and
      Srikumar, Vivek",
    booktitle = "Proceedings of the 62nd Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers)",
    month = aug,
    year = "2024",
    address = "Bangkok, Thailand",
    publisher = "Association for Computational Linguistics",
    url = "https://aclanthology.org/2024.acl-long.76/",
    doi = "10.18653/v1/2024.acl-long.76",
    pages = "1390--1415",
    abstract = "Historical linguists have identified multiple forms of lexical semantic change. We present a three-dimensional framework for integrating these forms and a unified computational methodology for evaluating them concurrently. The dimensions represent increases or decreases in semantic 1) sentiment (valence of a target word{'}s collocates), 2) intensity (emotional arousal of collocates or the frequency of intensifiers), and 3) breadth (diversity of contexts in which the target word appears). These dimensions can be complemented by evaluation of shifts in the frequency of the target words and the thematic content of its collocates. This framework enables lexical semantic change to be mapped economically and systematically and has applications in computational social science. We present an illustrative analysis of semantic shifts in \textit{mental health} and \textit{mental illness} in two corpora, demonstrating patterns of semantic change that illuminate contemporary concerns about pathologization, stigma, and concept creep."
}
```
---

## 📬 Contact

For questions, suggestions, or collaboration inquiries, contact:  
**Naomi Baes**  
📧 naomi_baes@hotmail.com  
🌐 [naomibaes.github.io](https://naomibaes.github.io)

---

## 🙏 Acknowledgements

Special thanks to my PhD supervisors, **Nick Haslam** and  **Ekaterina Vylomova**, for their guidance and supervision throughout the development of this work.

