#!/bin/bash


# Loop through each project folder in the current directory
for project_dir in ./*; do
  if [ -d "$project_dir" ]; then
    echo "Processing FASTQ files in: $project_dir"
    
    # Create a subdirectory for FastQC results
    mkdir -p "${project_dir}/fastqc_results"
    
    fastqc -o "${project_dir}/fastqc_results" --noextract --threads 4 "${project_dir}"/*.fastq.gz
    
    echo "FastQC completed for $project_dir. Results saved to ${project_dir}/fastqc_results"
  else
    echo "Directory not found: $project_dir"
  fi
done

echo "All FastQC analyses completed!"
