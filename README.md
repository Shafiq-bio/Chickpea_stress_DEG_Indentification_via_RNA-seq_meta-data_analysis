# Comparative Identification of Stress-Responsive Differentially Expressed Genes in Chickpea

## Overview
This repository contains all analysis code used in:

> Shafiq et al. (2026). "Comparative Identification of Stress-Responsive
> Differentially Expressed Genes in Chickpea (*Cicer arietinum* L.) Using
> Unsupervised Machine Learning, Traditional Meta-Analysis, and Statistical

This study integrates publicly available chickpea RNA-seq data across drought,
salt, and salinity stress conditions and applies three complementary approaches unsupervised machine learning (HDBSCAN), HN-score meta-analysis, and
conventional statistical testing (DESeq2, limma-voom) to identify robust
stress-responsive differentially expressed genes (DEGs).

---

## Repository Structure

```
Chickpea_stress_DEG_Identification_via_RNA-seq_meta-data_analysis/
│
├── README.md
│
├── 1_Genome_data_download/
│   └── Download_SRA_files.sh           # Automated SRA download and FASTQ conversion
│                                       # using SRA Toolkit (prefetch + fastq-dump)
│
├── 2_QC/
│   └── fastqc.sh                        # Read quality assessment (FastQC) and
│   └── cutadapt.sh                      # adapter trimming (Cutadapt)
│   └──multiqc.sh                        #Multiqc reports
├── 3_Alignment/
│   └── indexing.sh                    # Splice-aware alignment to chickpea reference
│   └── map.sh                         # genome using STAR
│
├── 4_Quantification/
│   └── Quant.sh                     # Gene-level read quantification using
│                                    # FeatureCounts (Subread package)
│
├── 5_Prepross_Normalization_distance matrics/
│   └── 1_drought stress          
│       └──  Prepross_Normalization_metrics_distance_performance_drought_stress.ipynb    # normalization, and StandardScaler scaling ansd 
│   └── 2_salt stress 									 # Count matrix merging, log2(x+1)
│       └──  Preprocess_and_Distance_metric_performance_3K.ipynb
│       └──  Preprocess_and_Distance_metric_performance_5K.ipynb    
│       └──  Preprocess_and_Distance_metric_performance_ALL.ipynb  
│   └── 3_salinity stress   
│       └── SRP059951
│           └── Preprocess_and_Distance_metric_performance_3K.ipynb 
│           └── Preprocess_and_Distance_metric_performance_5K.ipynb 
│           └── Preprocess_and_Distance_metric_performance_ALL.ipynb
│       └── SRP376874
│           └── Preprocess_and_Distance_metric_performance_3K.ipynb 
│           └── Preprocess_and_Distance_metric_performance_5K.ipynb 
│           └── Preprocess_and_Distance_metric_performance_ALL.ipynb
│
│                                                          
├── 6_Paramter_optimization_for_HDBSCAN/
│   └── 1_drought stress          
│       └──  HDBSCAN_parameter_optimization_and_Visulization.ipynb     # HDBSCAN distance metric optimization,
│   └── 2_salt stress 					        # grid search hyperparameter tuning,				
│       └──  HDBSCAN_grid_search_salt_stress.ipynb                      # and DEG identification via Cluster -1  
│   └── 3_salinity stress   
│       └── SRP059951
│           └── HDBSCAN_grid_search_salinity_stress_SRP059951.ipynb
│       └── SRP376874
│           └── HDBSCAN_grid_search_salinity_SRP376874.ipynb                                                    
│
├── 7_HN_score/
│   └── hn-ratios_and_scores.ipynb  # HN-ratio and HN-score calculation
│                                 # across thresholds HN2, HN5, and HN10
│
├── 8_statistical_analysis/
│   └── 1_drought stress          
│       └──  Deseq2_drougt_stress.R  
        └──  limma_drought_stress.R
│   └── 2_salt stress 					        				
│       └── Deseq2_salt_stress.R                         
│   └── 3_salinity stress   
│       └── SRP059951
│           └── Deseq2_salinity_stress.R
│       └── SRP376874
│           └── Deseq2_salinity_stress.R
│
└── 9_visualization/
    └── Visulization_of_enrichemnts_generalized_code.ipynb        
                                 
```

---

## Data Availability

All raw RNA-seq data used in this study are publicly available on NCBI SRA.
Bioproject accessions are listed in Table 1 of the manuscript.

| Stress | Bioprojects | Samples |
|--------|-------------|---------|
| Drought | ERP147995, SRP136396, SRP353613, SRP059919, SRP080728, SRP115250, SRP119439, SRP324396, SRP336117, SRP347104, SRP361761 | 199 |
| Salt |SRP226678| 1 |
| Salinity | SRP376874, SRP059951 | 2 |

---

## Dependencies

### Python (version 3.8+)
```
pandas
numpy
scikit-learn
hdbscan
matplotlib
```
Install via:
```bash
pip install pandas numpy scikit-learn hdbscan matplotlib
```

### R (version 4.0+)
```
DESeq2
edgeR
limma
metaRNAseq
ggplot2
```
Install via:
```r
install.packages("BiocManager")
BiocManager::install(c("DESeq2", "edgeR", "limma"))
install.packages(c("metaRNAseq", "ggplot2"))
```

### Command-line Tools
| Tool | Version | Purpose |
|------|---------|---------|
| SRA Toolkit | Latest | SRA download and FASTQ conversion |
| FastQC | 0.12.0 | Read quality assessment |
| Cutadapt | 5.2 | Adapter trimming |
| STAR | Latest | Genome alignment |
| Subread/FeatureCounts | 2.1.1 | Read quantification |

---

## Steps by step execution

# Step 1: Download SRA data

# Step 2: Quality control and adapter removal

# Step 3: Alignment

# Step 4: Quantification

# Step 5: Preprocessing, normalization and distance metric performance 

# Step 6: Parameter tunning for HDBSCAN ML analysis 

# Step 7: HN-score meta-analysis

# Step 8: Statistical analysis (run in R) for DESeq2 and limma_voom

# Step 9: Visualization

## Notes on Adapted Code

- The HN-score meta-analysis approach is adapted from:
  Tamura and Bono (2022), https://github.com/no85j/hypoxia_code
  Modifications: applied to chickpea abiotic stress RNA-seq data with
  custom thresholds (HN2, HN5, HN10)

- The DESeq2 and limma-voom scripts were developed
  specifically for this study to handle multi-bioproject drought stress data.

---

## Citation

If you use this code, please cite:

> Shafiq et al. (2025). Comparative Identification of Stress-Responsive
> Differentially Expressed Genes in Chickpea (*Cicer arietinum* L.) Using
> Unsupervised Machine Learning, Traditional Meta-Analysis, and Statistical
> Gene and Genomics

---

## Contact

For questions regarding the code or analysis, please contact:
[Mohammad Shafiq: shafiq.anjas@gmail.com]
