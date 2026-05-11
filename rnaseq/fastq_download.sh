#!/bin/bash
#SBATCH --job-name=sra_download
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=24:00:00
#SBATCH --output=logs/sra_download_%j.out
#SBATCH --error=logs/sra_download_%j.err

set -euo pipefail

spack load sratoolkit
spack load pigz

mkdir -p fastq logs

while read SRR; do
echo "Downloading ${SRR}"

fasterq-dump "$SRR" \
--split-files \
--threads 8 \
--outdir fastq \
> logs/${SRR}.fasterq.out \
2> logs/${SRR}.fasterq.err

if [[ -f fastq/${SRR}_1.fastq && -f fastq/${SRR}_2.fastq ]]; then
pigz -p 8 fastq/${SRR}_1.fastq fastq/${SRR}_2.fastq
else
echo "FAILED: ${SRR}" | tee -a logs/failed_downloads.txt
fi
done < SRR_list.txt