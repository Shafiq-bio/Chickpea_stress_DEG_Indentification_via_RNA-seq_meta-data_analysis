# RNA-seq Analysis Pipeline (STAR Indexing + Alignment)

This repository provides a reproducible RNA-seq workflow for **STAR genome indexing and alignment** across multiple BioProjects. FASTQ files are assumed to already be generated.

---

# 📁 Project Structure
project_root/
├── BioProject_1/
│ ├── *.fastq.gz
│
├── BioProject_2/
│ ├── *.fastq.gz
│
├── BioProject_3/
│ ├── *.fastq.gz
│
├── scripts/
│ ├── build_star_index.sh
│ ├── run_star_alignment.sh

Each BioProject folder contains paired-end FASTQ files:
- `*_1.fastq.gz`
- `*_2.fastq.gz`

---

# ⚙️ Step 1: Create Conda Environment

```bash
conda create -n rnaseq_env -c bioconda star -y
conda activate rnaseq_env