# HDBSCAN Clustering Analysis of Gene Expression Data

## Overview

This project implements an unsupervised clustering workflow for high-dimensional gene expression data using the Hierarchical Density-Based Spatial Clustering of Applications with Noise (HDBSCAN) algorithm. The analysis evaluates the impact of feature selection and distance metrics on clustering performance.

The workflow includes data preprocessing, normalization, variable gene selection, and clustering using multiple distance metrics.

---

## Workflow Summary

### 1. Data Import and Preprocessing

The analysis begins by importing the required Python libraries for data manipulation, statistical analysis, visualization, and clustering.

The gene expression dataset is then loaded, followed by an initial quality assessment that includes:

* Inspection of dataset dimensions
* Summary statistics
* Identification of missing values
* Removal of NA values

---

### 2. Data Normalization

To ensure comparability among samples and genes, normalization is performed prior to downstream analyses. This step reduces technical variation and improves clustering performance.

---

## Analysis Strategy

Three independent clustering workflows were performed and compared.

### Workflow 1: Top 3,000 Most Variable Genes

1. Calculate the standard deviation (SD) for each gene.
2. Rank genes according to variability.
3. Select the top 3,000 most variable genes.
4. Apply HDBSCAN clustering using multiple distance metrics:

   * Euclidean Distance
   * Manhattan Distance
   * Mahalanobis Distance
   * Correlation Distance

The resulting clusters and noise points are evaluated to determine clustering structure and robustness.

---

### Workflow 2: Top 5,000 Most Variable Genes

1. Calculate standard deviation for all genes.
2. Select the top 5,000 most variable genes.
3. Apply HDBSCAN clustering using the same distance metrics:

   * Euclidean Distance
   * Manhattan Distance
   * Mahalanobis Distance
   * Correlation Distance

This workflow assesses whether increasing the number of variable genes improves cluster detection and biological interpretation.

---

### Workflow 3: Complete Dataset

1. No standard deviation filtering is applied.
2. The entire normalized dataset is used.
3. HDBSCAN clustering is performed using:

   * Euclidean Distance
   * Manhattan Distance
   * Mahalanobis Distance
   * Correlation Distance

This analysis serves as a reference for evaluating the impact of feature selection on clustering outcomes.

---

## Distance Metrics Evaluated

### Euclidean Distance

Measures straight-line distance between observations in multidimensional space.

### Manhattan Distance

Measures distance as the sum of absolute differences across dimensions.

### Mahalanobis Distance

Accounts for correlations among variables and scales distances according to data covariance.

### Correlation Distance

Measures similarity based on expression patterns rather than absolute expression values.

---

## Software Requirements

### Python Packages

The analysis requires the following Python libraries:

```python
numpy
pandas
scipy
scikit-learn
hdbscan
matplotlib
seaborn
```

Additional libraries may be required depending on visualization and preprocessing steps implemented in the notebook.

---

## Expected Outputs

The workflow generates:

* Cluster assignments for each sample
* Identification of noise/outlier samples
* Comparative clustering results across distance metrics
* Comparative clustering results across feature-selection strategies
* Visualization of clustering structures
* Summary statistics describing cluster composition

---

## Project Objective

The primary objective of this project is to investigate how:

1. Feature selection based on gene variability,
2. The number of selected genes, and
3. Different distance metrics

influence HDBSCAN clustering performance in high-dimensional gene expression datasets.

The comparison between the top 3,000 genes, top 5,000 genes, and the complete dataset provides insight into the optimal preprocessing strategy for identifying biologically meaningful sample clusters.

---

## Author

Mohammad Shafiq

Research Specialist, Advanced Engineering School (Agrobiotek)
National Research Tomsk State University, Russia

Bioinformatics | Transcriptomics | Genomics | Data Science
