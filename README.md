# Bacterial Isolate Analysis: Species Identification and AMR Profiling

This project analyzes raw Oxford Nanopore (ONT) sequencing reads from an unknown bacterial isolate. The goal is to identify the organism and determine what antimicrobial resistance genes it carries, based only on the raw sequencing data.

## Summary of Findings

The organism was identified as *Klebsiella pneumoniae*, strain ST258, carrying a KPC-3 carbapenemase gene located on a mobile plasmid. Full details are in [`findings.md`](findings.md).

## Project Structure
```
├── data/                        # Input data goes here (not included in this repo, see below)
├── code/
│   ├── shell_scripts/            # Shell scripts for each analysis step (00-08)
│   └── analysis.ipynb            # Python notebook used to generate the figures
├── results/
│   ├── visualizations/           # Generated figures (used in findings.md)
│   ├── flye_assembly/            # Genome assembly output
│   ├── quast_report/             # Assembly quality report
│   ├── mobsuite/                 # Plasmid/chromosome classification
│   ├── nanoplot/                 # Read quality report
│   ├── abricate_card.tsv         # AMR gene detection results (CARD database)
│   ├── abricate_resfinder.tsv    # AMR gene detection results (ResFinder database)
│   ├── abricate_ncbi.tsv         # AMR gene detection results (NCBI database)
│   ├── abricate_vfdb.tsv         # Virulence factor detection results
│   ├── kraken2_report.txt        # Taxonomic classification summary
│   ├── kraken2_output.txt        # Per-read taxonomic classification
│   └── contig_lengths.tsv        # Per-contig lengths (from seqkit)
├── requirements.txt               # Python dependencies for the notebook
├── tool_versions.md               # Exact tool and database versions used
├── findings.md                    # Main report (start here)
└── README.md                      # This file
```

## Requirements

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) must be installed and running. All bioinformatics tools are run inside Docker containers, so no other software installation is needed for the pipeline itself.
- Python 3.9+ is only needed if you want to re-run the notebook that generates the figures.

## How to Run

### 1. Add the input data

Download `unknown_isolate.fastq.gz` and place it inside the `data/` folder: data/unknown_isolate.fastq.gz

### 2. Run the pipeline scripts in order

All commands are provided as shell scripts in `code/shell_scripts/`. Run them in numerical order from the project's root folder:

```bash
bash code/shell_scripts/00_data_check.sh
bash code/shell_scripts/01_nanoplot_qc.sh
bash code/shell_scripts/02_kraken2_classification.sh
bash code/shell_scripts/03_flye_assembly.sh
bash code/shell_scripts/04_quast_qc.sh
bash code/shell_scripts/05_mlst.sh
bash code/shell_scripts/06_abricate_amr.sh
bash code/shell_scripts/07_mobsuite_plasmids.sh
bash code/shell_scripts/08_abricate_vfdb.sh
```

Notes:
- Script `02` requires the Kraken2 Standard-8 database to be downloaded first. See the comments inside the script for the download command.
- Script `03` (genome assembly) is the slowest step and may take 20-40 minutes depending on your machine.
- If Docker runs out of memory during script `02` or `03`, see the comments inside those scripts for the fix we used (increasing WSL2 memory allocation via `.wslconfig` on Windows).

### 3. Generate the figures (optional)

To regenerate the figures used in the report:

```bash
python -m venv venv
venv\Scripts\Activate.ps1        # Windows
pip install -r code/requirements.txt
```

Then open `code/analysis.ipynb` in VS Code or Jupyter and run all cells.

## Output

All results are written to the `results/` folder. Tool and database versions used are documented in `tool_versions.md`.

## Report

The full findings report, including the note for the clinical team, methodology is in [`findings.md`](findings.md).

## Note on Excluded Files

Some files are not included in this repository because of their size:

- `data/unknown_isolate.fastq.gz` (raw input data, 439 MB): download from the link provided in the assessment and place it in the `data/` folder before running the pipeline.
- `kraken2_db/` (Kraken2 Standard-8 database, ~14 GB): this is downloaded automatically as part of running `code/shell_scripts/02_kraken2_classification.sh`. See the comments inside that script for the download command.
- `results/kraken2_output.txt` (123 MB): this is the per-read Kraken2 classification output. It exceeds GitHub's 100 MB file size limit. The summary file `results/kraken2_report.txt`, which contains all the data used in this report, is included.