# Retrieve Data
# raw_data retreived
load("R_Data/saved_raw_data")

# get miRNA names in order
miRNA_names <- rownames(raw_data)

# open .fa file
sequenceFile <- file("sequence_data/mature_withnovel.fa", open="r")

while(length(l <- readLines(sequenceFile, n=1, warn=FALSE)) > 0) {
	
}
# close .fa file
close(sequenceFile)