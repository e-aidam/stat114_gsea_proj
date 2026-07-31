# stat114_gsea_proj

Final project for Stat 114: *Introduction to Bioinformatics and Statistical Genetics*, focused on implementing a Gene Set Enrichment Analysis (GSEA) from scratch to identify biological pathways associated with the analyzed RNA-seq data.

## Authors

Victoria Chen, Anisha Kolambe, Ethan Aidam

## Project overview

This project analyzes bulk RNA-seq data from Whole Body Hyperthermia (WBH) and sham-treated samples to identify pathways associated with treatment response. Starting from a STAR-derived count matrix, the workflow performs quality filtering, differential expression analysis with DESeq2, and Gene Set Enrichment Analysis (GSEA) implementation from scratch. The GSEA from scratch results are then compared with preranked analyses from the Broad Institute GSEA desktop application.

The main analysis evaluates four biologically motivated gene sets:

- heat shock / proteostasis
- interferon signaling
- serotonin
- dopamine

## Biological Context

The dataset includes bulk RNA-seq from 19 whole blood samples from individuals with Major Depressive Disorder, collected 30
minutes after Whole Body Hyperthermia (WBH) or sham treatment. Based on Akonom et al.
(https://doi.org/10.1016/j.bbih.2026.101225), the analysis examines whether WBH affects heat shock, immune, dopamine, and
serotonin-related pathways.

## Repository contents

- `gsea_final_project.Rmd` — source R Markdown document for the full analysis
- `gsea_final_project.html` — rendered HTML report
- `gsea_final_project.pdf` — rendered PDF report
- `GSEA_Stat_114_Final_Presentation.pdf` — project presentation slides
- `setup.sh` — setup script for creating the RNA-seq project directory structure and downloading reference genome resources; intended to be run on a compute cluster environment with **Spack** available
- `rnaseq/` — scripts and supporting files for RNA-seq preprocessing and count generation

### `rnaseq/` directory

- `SRR_list.txt` — list of sequencing run accessions
- `fastq_download.sh` — download FASTQ files; intended to be run on a compute cluster environment with **Spack** available
- `fastqc_run.sh` — run FastQC quality control; intended to be run on a compute cluster environment with **Spack** available
- `star_index.sh` — build the STAR genome index; intended to be run on a compute cluster environment with **Spack** available
- `star_align.sh` — align reads with STAR; intended to be run on a compute cluster environment with **Spack** available
- `edge.R` — downstream count-processing / edgeR-related analysis script
- `edgeR.sh` — shell wrapper for running edgeR-related analysis; intended to be run on a compute cluster environment with **Spack** available
- `counts/` — generated count outputs

## Analysis workflow

The RNA-seq preprocessing shell scripts should be run in this order:

1. From the repository root, run `bash setup.sh` to create the `rnaseq/` directory structure, write `SRR_list.txt`, and download/unzip the GRCh38 FASTA and GENCODE GTF reference files.
2. From `rnaseq/`, submit `sbatch fastq_download.sh` to download paired FASTQ files for the SRR accessions.
3. Submit `sbatch fastqc_run.sh` to run FastQC quality control on the downloaded FASTQ files.
4. Submit `sbatch star_index.sh` to build the STAR genome index from the downloaded reference genome and annotation.
5. Submit `sbatch star_align.sh` to align each FASTQ pair to the STAR index and produce sorted BAM files plus STAR gene-count files.
6. Submit `sbatch edgeR.sh` to run `edge.R`, which combines the STAR `ReadsPerGene.out.tab` files into `counts/wbh_counts_matrix.csv`.

The R Markdown analysis in `gsea_final_project.Rmd` performs the following steps:

1. Loads a STAR-derived raw count matrix from `rnaseq/counts/wbh_counts_matrix.csv`
2. Maps Ensembl identifiers to HGNC gene symbols
3. Assigns samples to WBH and Sham groups
4. Filters low-expression genes using CPM thresholds
5. Runs differential expression analysis with **DESeq2**
6. Ranks genes by log2 fold change
7. Constructs gene sets from Gene Ontology Biological Process terms
8. Computes enrichment scores using GSEA implementation from scratch
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

The main report implements GSEA from scratch in R by ranking genes by DESeq2 log2 fold change, defining pathway gene sets from GO Biological Process annotations, and computing the weighted running enrichment score manually. Significance is estimated with phenotype-label permutations using log-CPM mean differences, followed by normalized enrichment scores (NES), empirical p-values, Benjamini-Hochberg adjusted p-values, and Storey q-values.

The custom implementation is compared with the Broad Institute GSEA desktop application using preranked input files generated from both DESeq2 and edgeR results. Those package/GUI runs use sex-adjusted differential expression rankings and MSigDB gene set collections. The GUI results broadly agree with the expected WBH biology by showing enrichment of heat-shock/protein-folding and neuronal/synaptic pathways, with edgeR producing somewhat stronger and more significant enrichment than DESeq2 in this analysis.

> **Cluster usage note:** The shell scripts in this repository (`*.sh`) are intended to be run in a cluster/HPC environment with **Spack** available for managing the required software.

## Notes

According to the analysis, none of the four tested gene sets reached statistical significance after multiple-testing correction, though the heat shock / proteostasis set showed the strongest enrichment signal among the tested pathways.
