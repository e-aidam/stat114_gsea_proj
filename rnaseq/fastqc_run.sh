#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=04:00:00
#SBATCH --output=logs/fastqc_%j.out
#SBATCH --error=logs/fastqc_%j.err

spack load fastqc

mkdir -p fastqc

fastqc fastq/*.fastq.gz \
  --outdir fastqc \
  --threads 8