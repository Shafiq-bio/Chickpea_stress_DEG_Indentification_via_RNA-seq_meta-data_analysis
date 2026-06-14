#!/bin/bash

ANNOTATION_GTF="/path/to/annotation.gtf"
THREADS=8

PROJECT_FOLDERS=(
    "../BioProject_1"
    "../BioProject_2"
    "../BioProject_3"
)

for PROJECT_DIR in "${PROJECT_FOLDERS[@]}"
do
    if [ ! -d "$PROJECT_DIR" ]; then
        echo "Missing: $PROJECT_DIR"
        continue
    fi

    echo "Processing: $PROJECT_DIR"

    INPUT_DIR="${PROJECT_DIR}/star_results"
    OUTPUT_FILE="${PROJECT_DIR}/gene_counts.csv"

    BAM_FILES=$(find "$INPUT_DIR" -name "*Aligned.sortedByCoord.out.bam")

    featureCounts \
        -T $THREADS \
        -a "$ANNOTATION_GTF" \
        -o "$OUTPUT_FILE" \
        -t exon \
        -g gene_id \
        $BAM_FILES

    echo "FeatureCounts completed for $PROJECT_DIR"
done

echo "All quantification completed"