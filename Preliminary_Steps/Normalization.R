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

#create a function to normalize data
#order the data set according to rank
quantile_normalize <- function(v) {
	v_order <- rank(v,ties.method="average")
	#set the quantiles based on the order
	quantiles <- v_order/53
	quantile_norm_vec <- qnorm(quantiles,mean=0,sd=1)
	return(quantile_norm_vec)	
}

output_matrix <- matrix(, nrow=m, ncol=n)
# create quantile normalization function for each miRNA
quantile_norm_data <- apply(uqnorm, 1, quantile_normalize)
quantile_norm_data <- t(quantile_norm_data)
str(quantile_norm_data)

# save final normalized data
save(quantile_norm_data, file="R_Data/saved_quantile_norm_data")