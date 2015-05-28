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

# find zero proportions for each miRNA
zero_counts_miRNA <- apply(raw_data, 1, count_zeros)
head(zero_counts_miRNA[,1:50])
hist(zero_counts_miRNA[1,])

# function to determine if all zeros
all_zeros <- function(v) {
	sum <- sum(v)
	if (sum == 0) {
		return(TRUE)
	}
	return(FALSE)
}

# Mark and delete all miRNAs with only zeros
only_zeros <- apply(raw_data, 1, all_zeros)
raw_data <- raw_data[!only_zeros,]
# Double check: find zero proportions for each miRNA
zero_counts_miRNA <- apply(raw_data, 1, count_zeros)
head(zero_counts_miRNA[,1:50])
hist(zero_counts_miRNA[1,])

#PCA analysis
#transpose data for PCA analysis
raw_data_trans <- t(raw_data)
dimnames(raw_data_trans) <- c(NULL, NULL)
str(raw_data_trans)
pca1 = prcomp(raw_data_trans, scale. = TRUE)
pca1$sdev
head(pca1$rotation)
head(pca1$x)
str(pca1$x)
