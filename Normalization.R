# insert data set
known_data <- read.delim("Data/known_miRNAs_expressed_all_samples.txt", header=TRUE)

# remove miRDeep2 "norm" data
known_data <- known_data[,1:56]

# extract raw data into matrix (just #s)
raw_data <- known_data[,5:56]
raw_data <- data.matrix(raw_data)

# UQ normalization function
UQNorm <- function(v) {
    quartiles <- quantile(v)
    uq <- quartiles[4]
    v <- v / uq
    return(v)
}

# normalize data
norm_data <- apply(raw_data, 1, UQNorm)