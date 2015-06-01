# insert data set
known_data <-read.delim("miRDeep2_Data/known_miRNAs_expressed_all_samples.txt", header=TRUE)

# extract raw data into matrix (just #s), exclude "norm" data
raw_data <- known_data[,5:56]
raw_data <- data.matrix(raw_data)

# save row names into matrix
miRNA_names <- known_data[,1]
rownames(raw_data) <- miRNA_names

# save raw data
save(raw_data, file="R_Data/saved_raw_data")

# function to count zeros, return proportions
count_zeros <- function(v) {
	len <- length(v)
	zero_bool <- v==0
	zero_count <- length(which(zero_bool == "TRUE"))
	nonzero_count <- len - zero_count
	props <- c(0, 0)
	props[1] <- zero_count / len
	props[2] <- nonzero_count / len
	return(props)
}

# find zero proportions for each sample
zero_counts_sample <- apply(raw_data, 2, count_zeros)

# find zero proportions for each miRNA
zero_counts_miRNA <- apply(raw_data, 1, count_zeros)

# save zero proportions (zero_count / len)
zero_props_miRNA <- zero_counts_miRNA[1,]
save(zero_props_miRNA, file="R_Data/saved_zero_props_miRNA")

# delete miRNAs that have >50% zeros
over_50 <- zero_props_miRNA > 0.5
processed_data <- raw_data[!over_50,]

# save processed data
save(processed_data, file="R_Data/saved_processed_data")