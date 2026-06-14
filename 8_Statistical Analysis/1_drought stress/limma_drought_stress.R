# =============================================================================
# limma-voom Analysis of Drought Stress RNA-seq Data
# Multiple bioprojects handled using duplicateCorrelation()
# Bioproject treated as a blocking factor
# Required R packages:
#   install.packages("BiocManager")
BiocManager::install(c("limma", "edgeR"))
a#   install.packages("ggplot2")
# =============================================================================

library(limma)
library(edgeR)
library(ggplot2)


setwd("D:/Chickpea data/drought stress")
# =============================================================================
# STEP 1: The metadata
# =============================================================================

metadata <- data.frame(
  SRA_Run = c(
    # ERP147995
    "ERR11526165","ERR11526166","ERR11526167",
    "ERR11526168","ERR11526169","ERR11526170",
    "ERR11526171","ERR11526172","ERR11526173",
    "ERR11526174","ERR11526175","ERR11526176",
    # SRP136396
    "SRR6893137","SRR6893138","SRR6893139","SRR6893140",
    "SRR6893141","SRR6893142","SRR6893143","SRR6893144",
    "SRR6893145","SRR6893146","SRR6893147","SRR6893148",
    "SRR6893149","SRR6893150","SRR6893151","SRR6893152",
    "SRR6893153","SRR6893154","SRR6893155","SRR6893156",
    "SRR6893157","SRR6893158","SRR6893159","SRR6893160",
    "SRR6893161","SRR6893162","SRR6893163","SRR6893164",
    "SRR6893165","SRR6893166","SRR6893167","SRR6893168",
    "SRR6893169","SRR6893170","SRR6893171","SRR6893172",
    "SRR6893173","SRR6893174","SRR6893175","SRR6893176",
    "SRR6893177","SRR6893178","SRR6893179","SRR6893180",
    "SRR6893181","SRR6893182","SRR6893183","SRR6893184",
    # SRP353613
    "SRR17443474","SRR17443475","SRR17443476","SRR17443477",
    "SRR17443478","SRR17443479","SRR17443480","SRR17443481",
    # SRP059919
    "SRR2079842","SRR2079843","SRR2079844","SRR2079845",
    "SRR2079846","SRR2079847","SRR2079848","SRR2079849",
    "SRR2079850","SRR2079851","SRR2079852","SRR2079853",
    "SRR2079854","SRR2079855",
    # SRP080728
    "SRR3990783","SRR3990784","SRR3990786","SRR3990788",
    # SRP115250
    "SRR5927129","SRR5927130","SRR5927132","SRR5927133",
    "SRR5927134","SRR5927135","SRR5927136",
    # SRP119439
    "SRR6132188","SRR6132189","SRR6132190","SRR6132191",
    "SRR6132192","SRR6132193","SRR6132194","SRR6132195",
    "SRR6132196","SRR6132197","SRR6132198","SRR6132199",
    # SRP324396
    "SRR14845044","SRR14845045","SRR14845046","SRR14845047",
    "SRR14845048","SRR14845049","SRR14845050","SRR14845051",
    # SRP336117
    "SRR15808115","SRR15808116","SRR15808117","SRR15808118",
    "SRR15808119","SRR15808120","SRR15808121","SRR15808122",
    "SRR15808123","SRR15808124","SRR15808125","SRR15808126",
    "SRR15808127","SRR15808128","SRR15808129","SRR15808130",
    "SRR15808131","SRR15808132","SRR15808133","SRR15808134",
    "SRR15808135","SRR15808136","SRR15808137","SRR15808138",
    "SRR15808139","SRR15808140","SRR15808141","SRR15808142",
    "SRR15808143","SRR15808144","SRR15808145","SRR15808146",
    "SRR15808147","SRR15808148","SRR15808149","SRR15808150",
    "SRR15808151","SRR15808152","SRR15808153","SRR15808154",
    "SRR15808155","SRR15808156","SRR15808157","SRR15808158",
    "SRR15808159","SRR15808160","SRR15808161","SRR15808163",
    "SRR15808164","SRR15808165","SRR15808166",
    # SRP347104
    "SRR16993480","SRR16993481","SRR16993482","SRR16993483",
    "SRR16993484","SRR16993485","SRR16993486","SRR16993487",
    "SRR16993488","SRR16993489","SRR16993490","SRR16993491",
    "SRR16993492","SRR16993493","SRR16993494","SRR16993495",
    "SRR16993496","SRR16993497","SRR16993498","SRR16993499",
    "SRR16993500","SRR16993501","SRR16993502","SRR16993504",
    "SRR16993505","SRR16993506","SRR16993507","SRR16993508",
    "SRR16993509","SRR16993510","SRR16993511",
    # SRP361761
    "SRR18163201","SRR18163202","SRR18163203",
    "SRR18163204","SRR18163207","SRR18163208"
  ),
  Bioproject = c(
    rep("ERP147995", 12),
    rep("SRP136396", 48),
    rep("SRP353613", 8),
    rep("SRP059919", 14),
    rep("SRP080728", 4),
    rep("SRP115250", 7),
    rep("SRP119439", 12),
    rep("SRP324396", 8),
    rep("SRP336117", 51),
    rep("SRP347104", 31),
    rep("SRP361761", 6)
  ),
  Condition = c(
    # ERP147995
    "Control","Control","Control",
    "Drought","Drought","Drought",
    "Control","Control","Control",
    "Drought","Drought","Drought",
    # SRP136396
    "Control","Control","Drought","Drought",
    "Drought","Drought","Control","Control",
    "Control","Control","Drought","Drought",
    "Drought","Drought","Drought","Drought",
    "Drought","Control","Control","Drought",
    "Drought","Drought","Drought","Drought",
    "Drought","Drought","Drought","Drought",
    "Drought","Drought","Drought","Drought",
    "Drought","Control","Control","Control",
    "Control","Drought","Drought","Drought",
    "Drought","Drought","Drought","Drought",
    "Control","Control","Control","Control",
    # SRP353613
    "Drought","Drought","Control","Control",
    "Drought","Drought","Control","Control",
    # SRP059919
    "Control","Drought","Control","Control",
    "Drought","Drought","Control","Control",
    "Drought","Drought","Control","Control",
    "Drought","Drought",
    # SRP080728
    "Drought","Control","Drought","Control",
    # SRP115250
    "Control","Drought","Drought","Control",
    "Drought","Control","Drought",
    # SRP119439
    "Control","Control","Control","Drought",
    "Drought","Drought","Control","Control",
    "Control","Drought","Drought","Drought",
    # SRP324396
    "Drought","Control","Drought","Control",
    "Drought","Control","Drought","Control",
    # SRP336117
    "Control","Drought","Control","Drought",
    "Drought","Control","Control","Drought",
    "Control","Drought","Control","Drought",
    "Control","Control","Drought","Control",
    "Drought","Drought","Control","Drought",
    "Control","Drought","Control","Drought",
    "Control","Drought","Control","Drought",
    "Control","Control","Drought","Control",
    "Control","Drought","Control","Drought",
    "Control","Drought","Control","Drought",
    "Drought","Control","Control","Drought",
    "Control","Drought","Control","Control",
    "Drought","Control","Control",
    # SRP347104
    "Control","Drought","Control","Drought",
    "Control","Drought","Control","Drought",
    "Control","Control","Drought","Control",
    "Drought","Control","Drought","Control",
    "Drought","Control","Drought","Drought",
    "Control","Drought","Control","Control",
    "Drought","Control","Drought","Control",
    "Drought","Control","Drought",
    # SRP361761
    "Drought","Drought","Drought",
    "Control","Control","Control"
  ),
  stringsAsFactors = FALSE
)

cat("Metadata loaded:", nrow(metadata), "samples\n")
cat("Condition table:\n")
print(table(metadata$Condition))
cat("Bioproject table:\n")
print(table(metadata$Bioproject))

# =============================================================================
# STEP 2: Load count matrix
# =============================================================================

cat("\nLoading count matrix...\n")
counts_raw <- read.csv("Count_drought.csv", row.names = 1, check.names = FALSE)
cat("Count matrix dimensions:", nrow(counts_raw), "genes x", ncol(counts_raw), "samples\n")

# =============================================================================
# STEP 3: Align metadata with count matrix columns
# =============================================================================

# Keep only samples present in both metadata and count matrix
common_samples <- intersect(colnames(counts_raw), metadata$SRA_Run)
cat("Common samples between count matrix and metadata:", length(common_samples), "\n")

counts <- counts_raw[, common_samples]
meta   <- metadata[match(common_samples, metadata$SRA_Run), ]

# Sanity check
stopifnot(all(colnames(counts) == meta$SRA_Run))
cat("Sample alignment verified.\n")

# Set factor levels — Control is reference
meta$Condition  <- factor(meta$Condition,  levels = c("Control", "Drought"))
meta$Bioproject <- factor(meta$Bioproject)

# =============================================================================
# STEP 4: Create DGEList and filter low-expression genes
# =============================================================================

cat("\nCreating DGEList and filtering low-expression genes...\n")
dge <- DGEList(counts = counts)

# Filter: keep genes with CPM > 1 in at least 4 samples
# (conservative threshold suitable for multi-bioproject data)
min_samples <- 4
keep <- rowSums(cpm(dge) > 1) >= min_samples
dge  <- dge[keep, , keep.lib.sizes = FALSE]
cat("Genes after filtering:", nrow(dge), "\n")

# =============================================================================
# STEP 5: TMM normalization
# =============================================================================

cat("Applying TMM normalization...\n")
dge <- calcNormFactors(dge, method = "TMM")

# =============================================================================
# STEP 6: Design matrix
# =============================================================================

design <- model.matrix(~ Condition, data = meta)
cat("\nDesign matrix (first 6 rows):\n")
print(head(design))

# =============================================================================
# STEP 7: voom transformation
# =============================================================================

cat("\nApplying voom transformation...\n")
png("voom_mean_variance_trend.png", width = 800, height = 600)
v <- voom(dge, design, plot = TRUE)
dev.off()
cat("voom mean-variance trend plot saved.\n")

# =============================================================================
# STEP 8: duplicateCorrelation — treat bioproject as blocking factor
# =============================================================================

cat("\nEstimating intra-bioproject correlation (iteration 1)...\n")
corfit1 <- duplicateCorrelation(v, design, block = meta$Bioproject)
cat("  Consensus correlation (iter 1):", round(corfit1$consensus.correlation, 4), "\n")

# Re-run voom with the estimated correlation for more stable weights
cat("Re-running voom with block correlation...\n")
v2 <- voom(dge, design,
           block = meta$Bioproject,
           correlation = corfit1$consensus.correlation,
           plot = FALSE)

# Second iteration for stable consensus correlation
cat("Estimating intra-bioproject correlation (iteration 2)...\n")
corfit2 <- duplicateCorrelation(v2, design, block = meta$Bioproject)
cat("  Consensus correlation (iter 2):", round(corfit2$consensus.correlation, 4), "\n")

# =============================================================================
# STEP 9: Fit linear model and compute DEGs
# =============================================================================

cat("\nFitting linear model...\n")
fit <- lmFit(v2, design,
             block = meta$Bioproject,
             correlation = corfit2$consensus.correlation)

fit <- eBayes(fit)

# Extract results for Drought vs Control
# coef = 2 corresponds to "ConditionDrought" in the design matrix
results <- topTable(fit,
                    coef     = 2,
                    number   = Inf,
                    sort.by  = "P",
                    adjust.method = "BH")   # Benjamini-Hochberg FDR

cat("\nTop 10 DEGs:\n")
print(head(results, 10))

# =============================================================================
# STEP 10: Filter significant DEGs
# =============================================================================

sig_degs <- results[results$adj.P.Val < 0.05 & abs(results$logFC) >= 0.4, ]
up_degs  <- sig_degs[sig_degs$logFC  >  0.4, ]
down_degs<- sig_degs[sig_degs$logFC  < -0.4, ]

cat("\n--- Significant DEGs Summary ---\n")
cat("Total significant DEGs (FDR < 0.05, |logFC| >= 0.4):", nrow(sig_degs), "\n")
cat("  Upregulated in Drought:  ", nrow(up_degs),   "\n")
cat("  Downregulated in Drought:", nrow(down_degs),  "\n")

# =============================================================================
# STEP 11: Save results to CSV
# =============================================================================

write.csv(results,  "limma_voom_all_genes_drought.csv",  row.names = TRUE)
write.csv(sig_degs, "limma_voom_DEGs_drought.csv",       row.names = TRUE)
cat("\nResults saved:\n")
cat("  limma_voom_all_genes_drought.csv — full results for all genes\n")
cat("  limma_voom_DEGs_drought.csv      — significant DEGs only\n")

