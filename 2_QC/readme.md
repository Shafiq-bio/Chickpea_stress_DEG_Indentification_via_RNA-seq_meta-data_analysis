# RNA-seq QC Pipeline (FastQC + MultiQC)

This repository provides a simple and reproducible workflow for quality control (QC) of RNA-seq FASTQ files using **FastQC** and **MultiQC**. The pipeline runs FastQC on all samples organized by project folders and then summarizes results using MultiQC.

---

## 📁 Directory Structure

Organize your data like this:
project_root/
├── ERP147995/
│ ├── sample1.fastq.gz
│ ├── sample2.fastq.gz
│
├── SRP136396/
│ ├── sample1.fastq.gz
│
├── SRP353613/
│ ├── sample1.fastq.gz
│
├── run_fastqc.sh
├── run_multiqc.sh


Each folder represents one BioProject and contains `.fastq.gz` files.

---

## 📌 Step 1: Create Conda Environment

Create a dedicated environment for QC analysis:

```bash
conda create -n qc_env -c bioconda fastqc multiqc -y

## Run the script
bash fastqc.sh

##For Mutliqc 
project_root/
├── ERP147995/
│   ├── fastqc_results/
├── SRP136396/
│   ├── fastqc_results/
│
├── multiqc_report/
│   ├── multiqc_report.html

##Run the multiqc script
bash multiqc.sh


