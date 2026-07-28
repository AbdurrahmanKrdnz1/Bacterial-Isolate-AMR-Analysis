#!/bin/bash
# Stage 5: Species and strain confirmation with MLST
# Purpose: Confirm species identity beyond the read-based Kraken2 estimate and determine the Sequence Type (ST) / clonal lineage using the standard 7-gene housekeeping scheme (PubMLST).

docker run --rm -v ${PWD}:/data staphb/mlst mlst \
  /data/results/flye_assembly/assembly.fasta

# Tool version: mlst 2.32.2 (staphb/mlst Docker image), PubMLST klebsiella scheme

# Result: Species confirmed as Klebsiella pneumoniae, Sequence Type ST258 (allele profile: gapA-3, infB-3, mdh-1, pgi-1, phoE-1, rpoB-1, tonB-79). ST258 is a well-documented high-risk clonal lineage strongly associated with carbapenem resistance (KPC) worldwide.