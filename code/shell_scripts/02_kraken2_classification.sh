#!/bin/bash
# Stage 2: Fast taxonomic classification with Kraken2
# Purpose: Get an early signal of species identity directly from raw reads, before committing time to assembly. Also serves as a contamination check.

# --- Database download (run once) ---
# mkdir kraken2_db && cd kraken2_db
# wget https://genome-idx.s3.amazonaws.com/kraken/k2_standard_08_GB_20260626.tar.gz
# tar -xzf k2_standard_08_GB_20260626.tar.gz
# cd ..
# Database: Kraken2 Standard-8 (RefSeq archaea, bacteria, viral, plasmid, human, UniVec_Core, capped at 8GB), release date 2026-06-26

docker run --rm -v ${PWD}:/data staphb/kraken2 kraken2 \
  --db /data/kraken2_db \
  --report /data/results/kraken2_report.txt \
  --output /data/results/kraken2_output.txt \
  /data/data/unknown_isolate.fastq.gz

# Result: 260,294 reads processed; 93.18% classified, 6.82% unclassified.
# Dominant signal: Klebsiella genus (74.26%), with Klebsiella pneumoniae as the clear leading species within that genus (16.82% direct assignment, far above other Klebsiella species). Minor background signal from E. coli (0.46%) and human DNA (0.01%), consistent with trace contamination rather than a mixed sample.