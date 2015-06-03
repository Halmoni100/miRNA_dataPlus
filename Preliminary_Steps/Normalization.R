# Retrieve Data
# processed_data retreived
load("R_Data/saved_raw_data")

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

# log norm data, save it
logged_data <- log2(uqnorm + 1)
save(logged_data, file="R_data/saved_logged_data")


# create quantile normalization function
quantile_normalization <- function(uqnorm) {
	uqnorm_rank <- apply(uqnorm, 2, rank, ties.method="min")
	uqnorm_sorted <- apply(uqnorm, 2, sort)
	
	#create the sampling function to add into the quantiles function
	sampling_vector <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52)
	sampling <- function(x) {
		divide <- x/53
		return(divide)
	}
	
	makingquantiles <- sapply(sampling_vector,sampling)	
	
	uqnorm_final <- function(uqnorm_sorted) {
		qnorm(makingquantiles, mean=0, sd=1)
		return(uqnorm_final)

	}
	return(quantile_normalization)
	}
	
# test the function
quantile_norm_data <- quantile_normalization(uqnorm)


# save final normalized data
save(quantile_norm_data, file="R_Data/saved_quantile_norm_data")