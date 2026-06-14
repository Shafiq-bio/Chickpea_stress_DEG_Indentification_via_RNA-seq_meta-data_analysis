#!/bin/bash

# =========================
# STAR alignment pipeline
# =========================

GENOME_DIR="/path/to/star_index"
THREADS=8

PROJECT_FOLDERS=(
    "../BioProject_1"
    "../BioProject_2"
    "../BioProject_3"
)

for PROJECT_DIR in "${PROJECT_FOLDERS[@]}"
do
    if [ ! -d "$PROJECT_DIR" ]; then
        echo "Missing folder: $PROJECT_DIR"
        continue
    fi

    echo "Processing: $PROJECT_DIR"

    OUTPUT_DIR="${PROJECT_DIR}/star_results"
    mkdir -p "$OUTPUT_DIR"

    cd "$PROJECT_DIR" || continue

    for R1_FILE in *_1.fastq.gz
    do
        [ -e "$R1_FILE" ] || continue

        # Sample name extraction
        SAMPLE_NAME=$(basename "$R1_FILE" | sed 's/_1\.fastq\.gz//')

        # Paired read
        R2_FILE="${SAMPLE_NAME}_2.fastq.gz"

        if [ ! -f "$R2_FILE" ]; then
            echo "Missing pair for: $SAMPLE_NAME"
            continue
        fi

        echo "Aligning sample: $SAMPLE_NAME"

        STAR --runThreadN $THREADS \
             --genomeDir "$GENOME_DIR" \
             --readFilesIn "$R1_FILE" "$R2_FILE" \
             --readFilesCommand zcat \
             --outFileNamePrefix "${OUTPUT_DIR}/${SAMPLE_NAME}_" \
             --outSAMtype BAM SortedByCoordinate \
             --quantMode GeneCounts

        echo "Finished: $SAMPLE_NAME"
    done

    cd - > /dev/null
done

echo "All STAR alignments completed"