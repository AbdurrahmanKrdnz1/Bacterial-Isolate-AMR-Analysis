#!/bin/bash
# Stage 7: Plasmid detection with MOB-suite
# Purpose: Formally classify each contig as chromosomal or plasmid-borne (rather than relying on contig size alone), and characterize plasmid incompatibility (Inc) type and mobilization potential — directly answering whether resistance genes could spread to other bacteria.

docker run --rm -v ${PWD}:/data staphb/mob-suite mob_recon \
  --infile /data/results/flye_assembly/assembly.fasta \
  --outdir /data/results/mobsuite \
  --force

# Tool version: MOB-suite (mob_recon) 3.1.9 (staphb/mob-suite Docker image)

# KEY FINDING: contig_15 (carrying KPC-3) was classified as a plasmid, cluster AA372, Inc type IncI2, with a MOBP relaxase gene detected — indicating conjugative transfer potential. IncI2 plasmids are known in the literature to be mobilizable between Enterobacteriaceae.
#
# 3 contigs classified as chromosomal (contig_4, contig_6, contig_18). 9 contigs distributed across 4 plasmid clusters: AA274 (contigs 1, 5, 7, 9, 10, 12; predominantly IncF/IncR types), AA372 (contig_15, IncI2), AD548 (contig_11), AB536 (contig_14).

# Note: contig size alone was not a reliable predictor — contig_6 (41,786 bp) and contig_18 (1,349 bp) were classified as chromosomal despite being much smaller than several plasmid contigs, underscoring the value of sequence-based plasmid detection over size heuristics.