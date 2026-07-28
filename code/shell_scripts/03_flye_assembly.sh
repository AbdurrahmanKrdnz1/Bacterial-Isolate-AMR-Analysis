#!/bin/bash
# Stage 3: Genome assembly with Flye
# Purpose: Assemble raw ONT long reads into draft genome contigs (chromosome + plasmids), which is required for MLST, AMR localization and plasmid/chromosome classification downstream.

docker run --rm -v ${PWD}:/data staphb/flye flye \
  --nano-raw /data/data/unknown_isolate.fastq.gz \
  --out-dir /data/results/flye_assembly \
  --threads 4

# Tool version: Flye 2.9.6-b1802 (staphb/flye Docker image)

# Note: The first attempt failed with "Looks like the system ran out of
# memory" (SIGKILL) because Docker Desktop's default WSL2 memory allocation
# was insufficient for the k-mer counting step on ~576 Mbp of reads (~100x
# coverage). Fix: created C:\Users\<user>\.wslconfig with:
#   [wsl2]
#   memory=12GB
#   processors=4
#   swap=4GB
# followed by `wsl --shutdown` to apply. After this, the assembly completed successfully in ~26 minutes.

# Result: Total length 5,896,333 bp across 12 contigs. Largest contig 5,306,074 bp (N50 = largest contig, ~90% of total assembly length), mean coverage 96x, alignment error rate 1.3% post-polishing.