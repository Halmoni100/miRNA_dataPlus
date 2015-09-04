# Retrieve Data
# processed_data retreived
load("R_Data/saved_processed_data")

# get miRNA names in order
miRNA_names <- rownames(processed_data)

# save miRNA names to .txt file
write.table(miRNA_names, "misc_data/saved_miRNA_names.txt", sep="\t",
		quote=FALSE, row.names=FALSE, col.names=FALSE)
		
# get precursor names in processed data
# prec_names_proc retrieved
load("R_data/saved_prec_names_proc")

# save precursor names in processed data in .txt file
write.table(prec_names_proc, "misc_data/saved_precursor_names.txt", sep="\t",
		quote=FALSE, row.names=FALSE, col.names=FALSE)