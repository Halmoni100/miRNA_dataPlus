# Read content table w/ sequence data
seq_df <- read.delim("Preliminary_Steps/sequence_content/content_table.txt")
head(seq_df)

# Create list for gc proportion
gc_prop_list <- seq_df$gc_prop
names(gc_prop_list) <- seq_df$miRNA
head(gc_prop_list)
