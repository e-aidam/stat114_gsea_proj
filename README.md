# stat114_gsea_proj

Final project for Stat 114: *Introduction to Bioinformatics and Statistical Genetics*, focused on implementing a custom Gene Set Enrichment Analysis (GSEA) workflow to identify biological pathways associated with whole body hyperthermia (WBH) treatment.

## Project overview

This repository contains the code, report, presentation materials, and RNA-seq processing scripts used for the final project analysis. The workflow begins with RNA-seq count generation and proceeds through differential expression analysis and a custom GSEA implementation in R.

The main analysis compares **WBH** and **Sham** samples and evaluates enrichment across biologically motivated gene sets, including:

- heat shock / proteostasis
- interferon signaling
- serotonin
- dopamine

## Repository contents

- `gsea_final_project.Rmd` — source R Markdown document for the full analysis
- `gsea_final_project.html` — rendered HTML report
- `gsea_final_project.pdf` — rendered PDF report
- `GSEA_Stat_114_Final_Presentation.pdf` — project presentation slides
- `setup.sh` — setup script for creating the RNA-seq project directory structure and downloading reference genome resources
- `rnaseq/` — scripts and supporting files for RNA-seq preprocessing and count generation

### `rnaseq/` directory

- `SRR_list.txt` — list of sequencing run accessions
- `fastq_download.sh` — download FASTQ files
- `fastqc_run.sh` — run FastQC quality control
- `star_index.sh` — build the STAR genome index
- `star_align.sh` — align reads with STAR
- `edge.R` — downstream count-processing / edgeR-related analysis script
- `edgeR.sh` — shell wrapper for running edgeR-related analysis
- `counts/` — generated count outputs

## Analysis workflow

The R Markdown analysis in `gsea_final_project.Rmd` performs the following steps:

1. Loads a STAR-derived raw count matrix from `rnaseq/count/wbh_counts_matrix.csv`
2. Maps Ensembl identifiers to HGNC gene symbols
3. Assigns samples to WBH and Sham groups
4. Filters low-expression genes using CPM thresholds
5. Runs differential expression analysis with **DESeq2**
6. Ranks genes by log2 fold change
7. Constructs gene sets from Gene Ontology Biological Process terms
8. Computes enrichment scores using a custom GSEA implementation
9. Estimates significance using phenotype permutation and normalized enrichment scores (NES)
10. Produces summary tables and enrichment visualizations

## Methods and tools

This project uses R/Bioconductor packages including:

- `DESeq2`
- `edgeR`
- `AnnotationDbi`
- `org.Hs.eg.db`
- `GO.db`
- `tidyverse`
- `gt`

RNA-seq preprocessing scripts are organized under `rnaseq/` and include steps for data download, quality control, STAR indexing, and alignment.

## Key outputs

- Reproducible analysis document in R Markdown
- Rendered HTML and PDF reports
- Presentation summarizing project results
- Supporting RNA-seq preprocessing scripts

## Notes

According to the rendered analysis, none of the four tested gene sets reached statistical significance after multiple-testing correction, though the heat shock / proteostasis set showed the strongest positive enrichment trend.
