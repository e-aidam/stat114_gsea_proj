files <- list.files("bam", pattern = "ReadsPerGene.out.tab$", full.names = TRUE)

read_star_counts <- function(f) {
  x <- read.delim(f, header = FALSE)
  x <- x[!grepl("^N_", x$V1), ]
  counts <- x$V2
  names(counts) <- x$V1
  counts
}

count_list <- lapply(files, read_star_counts)

counts <- do.call(cbind, count_list)
colnames(counts) <- sub(".ReadsPerGene.out.tab", "", basename(files))

dir.create("counts", showWarnings = FALSE)
write.csv(counts, "counts/wbh_counts_matrix.csv")