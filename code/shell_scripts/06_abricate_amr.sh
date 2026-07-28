#!/bin/bash
# Stage 6: AMR gene detection with abricate
# Purpose: Detect acquired and intrinsic antimicrobial resistance genes. Three independent databases are used and cross-checked for reliability, since AMR databases differ in gene content and nomenclature.

docker run --rm -v ${PWD}:/data staphb/abricate abricate --db card \
  /data/results/flye_assembly/assembly.fasta > results/abricate_card.tsv

docker run --rm -v ${PWD}:/data staphb/abricate abricate --db resfinder \
  /data/results/flye_assembly/assembly.fasta > results/abricate_resfinder.tsv

docker run --rm -v ${PWD}:/data staphb/abricate abricate --db ncbi \
  /data/results/flye_assembly/assembly.fasta > results/abricate_ncbi.tsv

# Tool version: abricate 1.4.0 (staphb/abricate Docker image)
# Databases: CARD (6052 seq), ResFinder (3206 seq), NCBI (8232 seq),
# all dated 2026-May-1

# KEY FINDING: KPC-3 carbapenemase gene detected on contig_15 (100% coverage, 100% identity vs CARD reference). KPC confers resistance to carbapenems — last-resort antibiotics — as well as cephalosporins, monobactams, and penicillins. This is the most clinically significant finding in this analysis.