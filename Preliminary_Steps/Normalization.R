# Retrieve Data
# processed_data retreived
load("R_Data/saved_raw_data")


# get rid of all non-zero counts to create a vector
nonzero_data <- subset(v, v > 0)


# UQ normalization function
UQNorm <- function(v) {
    nonzero_data <- subset(v, v > 0)
    quartiles <- quantile(nonzero_data)
    uq <- quartiles[4]
    return(uq)
} 



# vector of Us needed to normalize data
Us <- apply(raw_data, 2, UQNorm)


# finding mean of the of the uq samples
U <- mean(Us)


# load processed data
load("R_Data/saved_processed_data")

uqnorm <- matrix(, nrow=nrow(processed_data), ncol=ncol(processed_data))

# doing a for loop to normalize on each sample
for (i in 1:ncol(processed_data)) {
	colneeded <- processed_data[,i]
	uqnorm[,i] <- colneeded/Us[i]*U
}

logged <- log2(uqnorm + 1)
pca_analysis <- dget("Preliminary_Steps/analyze_PCs.r")
pca_analysis(uqnorm, 10)


# all code below here is adapted from http://davetang.org/muse/2014/07/07/quantile-normalisation-in-r/
# create quantile normalization function
quantile_normalization <- function(uqnorm) {
	uqnorm_rank <- apply(uqnorm, 2, rank, ties.method="min")
	uqnorm_sorted <- data.frame(apply(uqnorm, 2, sort))
	uqnorm_mean <- apply(uqnorm_sorted, 1, mean)
	
	index_to_mean <- function (my_index, my_mean) {
		return (my_mean[my_index])
	}
	
	uqnorm_final <- apply(uqnorm_rank, 2, index_to_mean, my_mean = uqnorm_mean)
	return(uqnorm_final)
}

# test the function
quantile_norm_data <- quantile_normalization(uqnorm)

# graph the normalized data on a histogram
hist(quantile_norm_data)