# Load packages
library("gplots", lib="R_packages")

# insert data set
known_data <- read.delim("Data/known_miRNAs_expressed_all_samples.txt", header=TRUE)

# subset vector for aaa into virus, healthy & bacteria
virus <- known_data[1,5:25]
baseline <- known_data[1,26:46]
bacteria <- known_data[1,47:56]
infection_status <- c(virus, baseline, bacteria)

# remove miRDeep2 "norm" data
known_data <- known_data[,1:56]

# extract raw data into matrix (just #s)
raw_data <- known_data[,5:56]
raw_data <- data.matrix(raw_data)
class(raw_data)

# make log2 heat map
log2_data <- log2(raw_data + 1)
heatmap.2(log2_data, trace="none")




