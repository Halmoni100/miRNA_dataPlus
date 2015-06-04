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

#create a function to normalize data
#order the data set according to rank
normalize <- function(uqnorm) {
uqnorm_order <- rank(uqnorm[i],ties.method="average")
	#set the quantiles based on the order
	quantiles <- uqnorm_order/53
	quantile_norm_data <- qnorm(quantiles,mean=0,sd=1)
	return(quantile_norm_data)	
}


output_matrix <- matrix(, nrow=m, ncol=n)
#loop through each row
# create quantile normalization function for each miRNA
quantile_normalization <- for (i in nrow(uqnorm)) {
uqnorm_order[i]
output_matrix = list()

}



# save final normalized data
save(quantile_norm_data, file="R_Data/saved_quantile_norm_data")