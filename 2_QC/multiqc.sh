#!/bin/bash

multiqc . \
  -o multiqc_report

echo "MultiQC report generated in multiqc_report/"