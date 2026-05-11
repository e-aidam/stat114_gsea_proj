#!/bin/bash
#SBATCH --job-name=star_align
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=90G
#SBATCH --time=12:00:00
#SBATCH --array=1-20
#SBATCH --output=logs/star_align_%A_%a.out
#SBATCH --error=logs/star_align_%A_%a.err

spack load star

mkdir -p bam

SRR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" SRR_list.txt)

echo "Aligning ${SRR}"

STAR \
  --runThreadN 12 \
  --genomeDir star_index \
  --readFilesIn fastq/${SRR}_1.fastq.gz fastq/${SRR}_2.fastq.gz \
  --readFilesCommand zcat \
  --outFileNamePrefix bam/${SRR}. \
  --outSAMtype BAM SortedByCoordinate \
  --quantMode GeneCounts