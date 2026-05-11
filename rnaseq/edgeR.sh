edgeR.sh
#!/bin/bash
#SBATCH --job-name=edgeR
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=logs/edgeR_%j.out
#SBATCH --error=logs/edgeR_%j.err

spack load r

Rscript edge.R