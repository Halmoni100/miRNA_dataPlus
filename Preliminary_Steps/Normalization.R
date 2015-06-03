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

	#create the sampling vector to add into the quantiles function
	sampling_vector <- 1:52
	makingquantiles <- sampling_vector / 53
	
	# setting quantiles argument
	quantiles <- qnorm(makingquantiles, mean=0, sd=1)
	
	# return something
	return()
}
	
# test the function
quantile_norm_data <- quantile_normalization(uqnorm)
str(quantile_norm_data)

# save final normalized data
save(quantile_norm_data, file="R_Data/saved_quantile_norm_data")