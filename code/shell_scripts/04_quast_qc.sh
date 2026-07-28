#!/bin/bash
# Stage 4: Assembly quality assessment with QUAST
# Purpose: Per-contig length, N50/N90, GC content, and other assembly quality metrics to evaluate assembly reliability.

docker run --rm -v ${PWD}:/data staphb/quast quast.py \
  /data/results/flye_assembly/assembly.fasta \
  -o /data/results/quast_report

# Tool version: QUAST 5.3.0 (staphb/quast Docker image)

# Result: 12 contigs, largest 5,306,074 bp, GC content 56.79% (consistent with the known ~57% GC content of Klebsiella pneumoniae — an independent confirmation of the species call from Kraken2). L50=1, L90=2, 0 ambiguous bases (N's) per 100kbp — a clean, gap-free assembly.

# Supplementary: exact per-contig lengths (QUAST's summary report only gives cumulative size thresholds, not per-contig values), obtained with seqkit:
docker run --rm -v ${PWD}:/data staphb/seqkit seqkit fx2tab -nl \
  /data/results/flye_assembly/assembly.fasta