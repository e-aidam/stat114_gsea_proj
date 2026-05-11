mkdir -p rnaseq/{sra,fastq,fastqc,genome,star_index,bam,counts,logs}
cd rnaseq

# SRR list
cat > SRR_list.txt <<EOF
SRR34413163
SRR34413164
SRR34413165
SRR34413166
SRR34413167
SRR34413168
SRR34413169
SRR34413170
SRR34413171
SRR34413172
SRR34413173
SRR34413174
SRR34413175
SRR34413176
SRR34413177
SRR34413178
SRR34413179
SRR34413180
SRR34413181
SRR34413182
EOF

cd genome

wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_49/GRCh38.primary_assembly.genome.fa.gz

wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_49/gencode.v49.annotation.gtf.gz

gunzip GRCh38.primary_assembly.genome.fa.gz
gunzip gencode.v49.annotation.gtf.gz

cd ..
