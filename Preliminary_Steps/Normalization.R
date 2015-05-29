# Retrieve Data
# processed_data retreived
load("R_Data/saved_processed_data")

# UQ normalization function
UQNorm <- function(v) {
    quartiles <- quantile(v)
    uq <- quartiles[4]
    v <- v / uq
    return(v)
}

# normalize data
norm_data <- apply(processed_data, 1, UQNorm)