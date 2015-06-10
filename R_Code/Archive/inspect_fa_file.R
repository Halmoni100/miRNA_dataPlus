# Retrieve Data
# raw_data retreived
load("R_Data/saved_raw_data")

# get miRNA names in order
miRNA_names <- rownames(raw_data)

# get lines from .fa file
fa_file_lines <- readLines("sequence_data/mature_withnovel.fa")
# get miRNA names from .fa file
fa_miRNA_names <- fa_file_lines[seq(1, length(miRNA_names)*2, 2)]
# get rid of "<" character
for (i in 1:length(fa_miRNA_names)) {
	s <- fa_miRNA_names[i]
	s <- substr(s,2,nchar(s))
	fa_miRNA_names[i] <- s
}
# get sequence data from .fa file
fa_sequences <- fa_file_lines[seq(2, length(miRNA_names)*2, 2)]

# check that next miRNA name in .fa file is "ch" (novel)
# and that there will probably be a 1-1 mapping
next_miRNA_name <- fa_file_lines[length(miRNA_names)*2 + 1]
if (next_miRNA_name != ">provisional id") {
	stop("# of known miRNAs in .fa file not equal # of miRNAs in raw_data")
}

# check if miRNA names are identical
if (identical(miRNA_names, fa_miRNA_names)) {
	print("miRNA names from .fa file and raw_data in same order")
}