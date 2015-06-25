###############
# Retrieve Data
###############

# insert data set
known_data <-read.delim("Data_in/known_miRNAs_expressed_all_samples.txt", header=TRUE)

# extract raw data into matrix (just #s), exclude "norm" data
data_raw <- known_data[,5:56]
data_raw <- data.matrix(data_raw)

# save miRNA names
miRNA_names <- known_data[,1]
# save precursor names
prec_names <- known_data[,3]

# function to count zeros, return proportions
count_zeros <- function(v) {
	len <- length(v)
	zero_bool <- v==0
	zero_count <- length(which(zero_bool == "TRUE"))
	prop <- zero_count / len
	return(prop)
}


###############
# Eliminate >50% zero proportions
###############

# find zero proportions for each miRNA
zero_prop_miRNA <- apply(data_raw, 1, count_zeros)

# delete miRNAs that have >50% zeros
over_50 <- zero_prop_miRNA > 0.5
data_proc <- data_raw[!over_50,]

# get miRNA names for data_proc
miRNA_names_proc <- miRNA_names[!over_50]
# get precursor names for data_proc
prec_names_proc <- prec_names[!over_50]


###############
# Normalize Data
###############

# UQ normalization function
uq_normalize <- function(v) {
    nonzero_data <- subset(v, v > 0)
    quartiles <- quantile(nonzero_data)
    uq <- quartiles[4]
    return(uq)
}

# vector of Us needed to normalize data
Us <- apply(data_raw, 2, uq_normalize)
# finding mean of the of the uq samples
U <- mean(Us)

# do UQ normalization
uqnorm <- matrix(, nrow=nrow(data_proc), ncol=ncol(data_proc))
# doing a for loop to normalize on each sample
for (i in 1:ncol(data_proc)) {
	col <- data_proc[,i]
	uqnorm[,i] <- col/Us[i]*U
}

# quantile normalization function
quantile_normalize <- function(v) {
	v_order <- rank(v,ties.method="average")
	#set the quantiles based on the order
	quantiles <- v_order/53
	quantile_norm_vec <- qnorm(quantiles,mean=0,sd=1)
	return(quantile_norm_vec)	
}

# do quantile normalization
# create quantile normalization function for each miRNA
q_norm_data <- apply(uqnorm, 1, quantile_normalize)
q_norm_data <- t(q_norm_data)
# debugging check
print(paste("m =", nrow(q_norm_data)))
print(paste("n =", ncol(q_norm_data)))


###############
# Format Data Frame
###############

# transpose data_proc, name it as data
data <- t(q_norm_data)

# Get m (# rows) and n (# cols) for data
# m represents samples, n represents features
m <- nrow(data)
n <- ncol(data)

# name samples s1, s2, etc.
s_names <- vector(mode="character", length=m)
for (i in 1:m) {
	s_name <- paste("s", i, sep="")
	s_names[i] <- s_name
}
# name features f1, f2, etc.
f_names <- vector(mode="character", length=n)
for (i in 1:n) {
	f_name <- paste("f", i, sep="")
	f_names[i] <- f_name
}

# make data into data frame, assign sample & feature names
df <- as.data.frame(data)
rownames(df) <- s_names
colnames(df) <- f_names

# make data frame describing features
features <- f_names
feat_df <- cbind.data.frame(features, miRNA_names_proc, prec_names_proc)
features_cols <- c("names", "miRNA", "precursor")
colnames(feat_df) <- features_cols

# save data frames for data and features
save(df, feat_df, file="Data_out/data_frames.r")



