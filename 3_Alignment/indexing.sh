#!/bin/bash

# =========================
# STAR genome indexing
# =========================

GENOME_FASTA="/path/to/genome.fa"
GTF_FILE="/path/to/annotation.gtf"
INDEX_DIR="/path/to/star_index"

THREADS=8

mkdir -p "$INDEX_DIR"

STAR --runThreadN $THREADS \
     --runMode genomeGenerate \
     --genomeDir "$INDEX_DIR" \
     --genomeFastaFiles "$GENOME_FASTA" \
     --sjdbGTFfile "$GTF_FILE" \
     --sjdbOverhang 100

echo "STAR indexing completed"