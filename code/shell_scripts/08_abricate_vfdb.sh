#!/bin/bash
# Stage 8: Virulence factor detection with abricate
# Purpose: Screen for known virulence factors to characterize pathogenic potential beyond antimicrobial resistance (addresses "anything else worth noting" in the assessment brief).

docker run --rm -v ${PWD}:/data staphb/abricate abricate --db vfdb \
  /data/results/flye_assembly/assembly.fasta > results/abricate_vfdb.tsv

# Tool version: abricate 1.4.0 (staphb/abricate Docker image)
# Database: VFDB, 4592 sequences, 2026-May-1

# Result: 61 virulence genes detected, almost entirely on the chromosome (contig_4) — consistent with these being intrinsic, species-level traits rather than acquired elements.

# NOT detected — this does not appear to be a hypervirulent "super-strain", but a standard, well-equipped Klebsiella pneumoniae virulence profile.