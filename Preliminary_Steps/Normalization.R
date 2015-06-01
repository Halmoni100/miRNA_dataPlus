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


#load preprocessCore package
library(preprocessCore)



# do quantile normalization on each sample
normalize.quantiles(uqnorm, copy = TRUE)
