# 🧠 SIBling Framework  
*A Multidimensional Framework for Evaluating Lexical Semantic Change with Social Science Applications*

Baes, N., Haslam, N., & Vylomova, E. (2024).  
*A Multidimensional Framework for Evaluating Lexical Semantic Change with Social Science Applications.*  
In *Proceedings of the 62nd Annual Meeting of the Association for Computational Linguistics (ACL 2024)*. [📄 ACL Anthology Link](https://aclanthology.org/2024.acl-long.76/)

---

## 📄 About

**SIBling** proposes a unified, psychologically grounded framework for analyzing and categorizing lexical semantic change (LSC) along three interpretable and quantifiable dimensions:

- **Sentiment**: positive ↔ negative  
- **Intensity**: strong ↔ weak  
- **Breadth**: wide ↔ narrow  

This framework reduces traditional lexical change types (e.g., amelioration, narrowing) into three continuous, empirically testable axes—enabling concurrent evaluation of meaning shifts over time.

> 🔁 See the applied implementation and evaluation framework here: [LSC-Eval](https://github.com/naomibaes/LSC-Eval)

---

## 🟢 🔴 🔵 Dimensions of Change

| Dimension   | Definition | Rising Example | Falling Example |
|-------------|------------|----------------|-----------------|
| 🟢 **Sentiment** | Change in a word’s evaluative connotation: does it acquire more positive (*elevation*) or negative (*pejoration*) meaning? | *geek* (derogatory → enthusiast) | *retarded* (clinical → pejorative) |
| 🔴 **Intensity** | Shift in emotional or referential force: does the meaning become stronger (*hyperbole*) or weaker (*meiosis*)? | *hilarious* (from cheerful → extreme laughter) | *trauma* (from injury → mild adversity) |
| 🔵 **Breadth** | Shift in semantic scope: does the meaning expand (*generalization*) or contract (*specialization*)? | *cloud* (weather → internet storage) | *meat* (any food → animal flesh) |

These three axes mirror affective and connotational dimensions validated in psychology and semantics (e.g., Valence–Arousal, Evaluation–Potency).

---

## 📁 Repository Structure

| Folder/File | Description |
|-------------|-------------|
| `sentiment/` | Scripts and examples related to tracking evaluative shifts in word meaning |
| `breadth/` | Scripts and datasets for measuring range expansion/contraction (e.g., using distributional spread or lexical taxonomies) |
| `intensity/` | Scripts for modeling change in emotional or referential strength (e.g., arousal scores, metaphorical inflation) |
| `environment.txt` | Package environment specifications for reproducibility in R and Python |
| `slurm_scripts/` | HPC (Spartan) job submission files for large-scale corpus processing |
| `README.md` | You are here! |

---

## 🧪 Methodological Foundations

SIBling maps six classical types of semantic change (e.g., amelioration, narrowing, hyperbole) to **three orthogonal semantic dimensions**. This enables:

- **Concurrent quantification** of multiple kinds of change  
- **Greater sensitivity** to subtle, co-occurring shifts in word meaning  
- **Alignment with psychological theories** of concept representation and cultural change  

> See [Figure 1 and Table 1](https://aclanthology.org/2024.acl-long.76/#appendix) in the ACL 2024 paper for full theoretical mapping.

---

## 🔗 Companion Resources

- [📁 LSC-Eval](https://github.com/naomibaes/LSC-Eval): End-to-end evaluation framework for LSC models using synthetic change detection benchmarks built on the SIBling framework.  
- [📁 Synthetic-LSC Pipeline](https://github.com/naomibaes/Synthetic-LSC_pipeline): Generation of synthetic corpora with controlled SIB changes using GPT and WordNet.  
- [📁 Psychology Corpus](https://github.com/naomibaes/psychology_corpus): Year-partitioned corpus used in proof-of-concept case studies.

---
### 🛠️ Languages and Environments

**Programming Languages**  
- **Python**: Core analysis and modeling scripts (`*.py`, Jupyter Notebooks)  
- **R**: Statistical analysis, mixed-effects modeling, and plotting (`*.R`)  
- **Bash**: Shell scripts for preprocessing and job scheduling (`*.sh`)

**Computational Environments**  
- **Spartan (HPC)**: Used for large-scale preprocessing, embedding extraction, and SLURM-based job execution  
- **VS Code / Local IDEs**: Recommended for running Python and R scripts locally, using Conda (Python) and `renv` (R) for reproducibility

---
## 📚 Citation

If you use the SIBling framework or its code in your work, please cite the original theoretical paper:

```bibtex
@inproceedings{baes-etal-2024-sibling,
  title = {A Multidimensional Framework for Evaluating Lexical Semantic Change with Social Science Applications},
  author = {Baes, Naomi and Haslam, Nick and Vylomova, Ekaterina},
  booktitle = {Proceedings of the 62nd Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers)},
  year = {2024},
  pages = {1390--1415},
  publisher = {Association for Computational Linguistics},
  address = {Bangkok, Thailand}
}
