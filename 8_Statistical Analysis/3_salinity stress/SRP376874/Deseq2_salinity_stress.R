
# =============================================================================
# DESeq2 Analysis of Salt Stress RNA-seq Data
# Required R packages:
#   install.packages("BiocManager")
#   BiocManager::install(c("DESeq2"))
#   install.packages("ggplot2")
# =============================================================================
#Load Library and set the working location.
library("DESeq2")
library(apeglm)
setwd("/home/shafeeq/D:Drive/Chickpea data/Salinity/SRP376874")
# =============================================================================
#Load the data including the meta-data and create DESeqDatasets
# =============================================================================
counts <- read.csv("gene_counts.csv", row.names=1)
coldata <- read.csv("meta_data.csv", row.names=1)
all(rownames(coldata) == colnames(counts))
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = coldata,
                              design = ~ condition )
# =============================================================================
#Filter low counts (optional but common)
# Run DESeq2
#retrive the analysis results
# =============================================================================

dds <- dds[rowSums(counts(dds)) > 10, ]

dds <- DESeq(dds)
res <- results(dds, contrast=c("condition","Stress","Control"))
resultsNames(dds)
res <- lfcShrink(dds,
                 coef="condition_Stress_vs_Control",
                 type="apeglm")
resOrdered <- res[order(res$padj), ]
# =============================================================================
#Save results
#plot the results
# =============================================================================

write.csv(as.data.frame(resOrdered), file="DESeq2_results.csv")
plotMA(res, ylim=c(-2,2))
plotCounts(dds, gene="GENE_ID", intgroup="condition")
# =============================================================================
#Save the significant DEGs

#significant  DEGS
# =============================================================================

sig_res <- res[which(res$padj < 0.9), ]

# Order by adjusted p-value
sig_res <- sig_res[order(sig_res$padj), ]
write.csv(as.data.frame(sig_res), file="DESeq2_significant_DEGs.csv")

