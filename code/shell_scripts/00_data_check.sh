#!/bin/bash
# Stage 0: Raw data validation
# Purpose: Confirm the file is not corrupted and conforms to FASTQ format

zcat data/unknown_isolate.fastq.gz | head -n 8
zcat data/unknown_isolate.fastq.gz | wc -l

# Result: 1,041,176 lines / 4 = 260,294 reads (evenly divisible, confirms structural integrity)