#!/bin/bash

set -euo pipefail

THREADS=8

for dir in */
do
echo "Processing $dir"

```
cd "$dir"

mkdir -p fastq

while read SRR
do
    [ -z "$SRR" ] && continue

    echo "Downloading $SRR"

    prefetch "$SRR"

    fasterq-dump "$SRR" \
        --split-files \
        --threads $THREADS \
        --outdir fastq

done < SRR_accessions.txt

gzip fastq/*.fastq

cd ..
```

done

echo "All projects completed"
