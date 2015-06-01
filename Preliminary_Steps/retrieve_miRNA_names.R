# Retrieve Data
# raw_data retreived
load("R_Data/saved_raw_data")

# get miRNA names in order
miRNA_names <- rownames(raw_data)

# save miRNA names to .txt file
write.table(miRNA_names, "misc_data/saved_miRNA_names.txt", sep="\t",
		quote=FALSE, row.names=FALSE, col.names=FALSE)