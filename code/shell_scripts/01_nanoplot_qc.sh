#!/bin/bash
# Stage 1: Quality control with NanoPlot
# Purpose: Statistical summary of read length, quality score, and total yield

docker run --rm -v $(pwd):/data staphb/nanoplot NanoPlot \
  --fastq /data/data/unknown_isolate.fastq.gz \
  --outdir /data/results/nanoplot

# Tool version: NanoPlot 1.46.2 (staphb/nanoplot Docker image)
# Key results: N50 = 15,932 bp, mean quality Q20.1, total yield ~576.6 Mbp