#!/bin/bash
#SBATCH --job-name=star_index
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=90G
#SBATCH --time=12:00:00
#SBATCH --output=logs/star_index_%j.out
#SBATCH --error=logs/star_index_%j.err

spack load star

mkdir -p star_index

STAR \
  --runThreadN 16 \
  --runMode genomeGenerate \
  --genomeDir star_index \
  --genomeFastaFiles genome/GRCh38.primary_assembly.genome.fa \
  --sjdbGTFfile genome/gencode.v49.annotation.gtf \
  --sjdbOverhang 149