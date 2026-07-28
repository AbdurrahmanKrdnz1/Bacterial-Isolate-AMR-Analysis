# Tool and Database Versions
This file records the version of every tool and reference database used
in this analysis. AMR and taxonomy databases are updated frequently, so
the same raw reads can yield different results across versions — this
information is kept for reproducibility.

## Stage 1: Quality Control
- Tool: NanoPlot
- Version: 1.46.2
- Docker image: staphb/nanoplot
- Purpose: Statistical summary of read length, quality score, and total yield

## Stage 2: Taxonomic Classification (raw reads)
- Tool: Kraken2
- Docker image: staphb/kraken2
- Database: Kraken2 Standard-8 (RefSeq archaea, bacteria, viral, plasmid,
  human, UniVec_Core; capped at 8GB)
- Database release date: 2026-06-26
- Purpose: Fast species-level signal directly from raw reads, and an early
  contamination check, before committing time to assembly

## Stage 3: Genome Assembly
- Tool: Flye
- Version: 2.9.6-b1802
- Docker image: staphb/flye
- Purpose: Assemble raw ONT long reads into draft genome contigs

## Stage 4: Assembly Quality Assessment
- Tool: QUAST
- Docker image: staphb/quast
- Version: 5.3.0
- Purpose: Per-contig length, N50/N90, GC content, and other assembly
  quality metrics

## Stage 5: Species/Strain Confirmation
- Tool: mlst
- Version: 2.32.2
- Docker image: staphb/mlst
- Scheme source: PubMLST (klebsiella scheme)
- Purpose: Confirm species identity and determine Sequence Type (ST) /
  clonal lineage using 7 housekeeping genes

## Stage 6: AMR Gene Detection
- Tool: abricate
- Version: 1.4.0
- Docker image: staphb/abricate
- Databases used:
  - CARD: 6052 sequences, 2026-May-1
  - ResFinder: 3206 sequences, 2026-May-1
  - NCBI AMRFinderPlus dataset: 8232 sequences, 2026-May-1
- Purpose: Detect acquired and intrinsic antimicrobial resistance genes;
  cross-checked across three independent databases for reliability

## Stage 7: Plasmid Detection
- Tool: MOB-suite (mob_recon)
- Version: 3.1.9
- Docker image: staphb/mob-suite
- Purpose: Classify contigs as chromosomal or plasmid-borne, determine
  plasmid incompatibility (Inc) type and predicted mobility

## Stage 8: Virulence Factor Detection
- Tool: abricate
- Version: 1.4.0
- Docker image: staphb/abricate
- Database: VFDB (Virulence Factor Database), 4592 sequences, 2026-May-1
- Purpose: Screen for known virulence factors (adhesion, iron acquisition,
  capsule, secretion systems) to characterize pathogenic potential beyond
  antimicrobial resistance