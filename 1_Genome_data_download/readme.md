# SRA RNA-seq Download and Processing Pipeline (SRA Toolkit)

This repository provides a simple and reproducible workflow to download and process RNA-seq datasets from NCBI SRA using the SRA Toolkit. The pipeline supports multiple BioProjects and automates download, conversion, and compression of sequencing data.

---

## 📁 Project Structure

Create the following directory structure:
project_root/
├── SRP.example./
│ └── SRR_accessions.txt
├── SRP..example.../
│ └── SRR_accessions.txt
├── ERP.example.../
│ └── SRR_accessions.txt
├── run_all.sh



Each BioProject folder represents one study and contains the corresponding run accession list.

---

## 📌 Step 1: Create Conda Environment

##Install and activate a dedicated environment for reproducibility.
conda create -n sra_env -c bioconda sra-tools -y
conda activate sra_env