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
	
	# Seems like you just made a vector from 1 to 52
	#create the sampling function to add into the quantiles function
	sampling_vector <- 1:52
	
	# Using sapply is wordy
	makingquantiles <- sampling_vector / 53
	
	# You don't need to make a function to create the vector of quantiles, since you will only be doing that once
	# The default values for qnorm are mean=0 and sd=1, so I don't think you have to specify those
	quantiles <- qnorm(makingquantiles)

	# The last (and probably most complicated step) you have to do is sort the quantiles by the rank.  idk how to do that yet
	# I think you return the sorted quantiles
	#return()
}
	
# test the function
quantile_norm_data <- quantile_normalization(uqnorm)


# save final normalized data
save(quantile_norm_data, file="R_Data/saved_quantile_norm_data")