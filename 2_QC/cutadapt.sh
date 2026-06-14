#!/bin/bash

# Input and output directories
INPUT_DIR="./raw_fastq"
OUTPUT_DIR="./trimmed_fastq"

mkdir -p ${OUTPUT_DIR}

# Loop through all R1 files
for R1 in ${INPUT_DIR}/*_R1*.fastq.gz
do
    BASENAME=$(basename ${R1})

    # Remove R1 portion to get sample name
    SAMPLE=$(echo ${BASENAME} | sed 's/_R1.*\.fastq\.gz//')

    # Search for matching R2 file
    R2=$(ls ${INPUT_DIR}/${SAMPLE}_R2*.fastq.gz 2>/dev/null)

    echo "Processing sample: ${SAMPLE}"

    if [ -f "${R2}" ]; then
        echo "Detected paired-end reads"

        cutadapt \
            -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
            -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
            -q 20 \
            -m 30 \
            -o ${OUTPUT_DIR}/${SAMPLE}_R1_trimmed.fastq.gz \
            -p ${OUTPUT_DIR}/${SAMPLE}_R2_trimmed.fastq.gz \
            ${R1} ${R2}

    else
        echo "Detected single-end reads"

        cutadapt \
            -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
            -q 20 \
            -m 30 \
            -o ${OUTPUT_DIR}/${SAMPLE}_trimmed.fastq.gz \
            ${R1}
    fi

done