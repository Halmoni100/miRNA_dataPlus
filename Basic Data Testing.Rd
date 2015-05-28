

# insert data set
setwd("~/Desktop/Data+/miRNA_dataPlus/Data")
known_data <- read.delim("known_miRNAs_expressed_all_samples.txt", header=TRUE)



# subset vector for aaa into virus, healthy & bacteria
virus <- known_data[1,5:25]
baseline <- known_data[1,26:46]
bacteria <- known_data[1,47:56]
infection_status <- c(virus, baseline, bacteria)

# remove miRDeep2 "norm" data
known_data <- known_data[,1:56]


# extract raw data into matrix (just #s)
raw_data <- known_data[,5:56]
raw_data <- data.matrix(raw_data)
class(raw_data)

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
head(zero_counts_sample)

# find zero proprotions for each miRNA
zero_counts_miRNA <- apply(raw_data, 1, count_zeros)
head(zero_counts_miRNA[,1:50])
hist(zero_counts_miRNA[1,])



