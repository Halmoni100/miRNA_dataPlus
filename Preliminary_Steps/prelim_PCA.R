
# Retrieve Data
# raw_data retreived
load("R_Data/saved_raw_data")

#transpose data for PCA analysis
raw_data_trans <- t(raw_data)
dimnames(raw_data_trans) <- c(NULL, NULL)
str(raw_data_trans)
pca1 = prcomp(raw_data_trans, scale. = TRUE)

#PCA analysis
#source:http://gastonsanchez.com/blog/how-to/2012/06/17/PCA-in-R.html
pca1 = prcomp(raw_data, scale. = TRUE)

# Graph PCA
pca_result <- pca1$x
pca_comp_1 <- pca_result[,1]
pca_comp_2 <- pca_result[,2]
pca_comp_3 <- pca_result[,3]

pca_comp_1_viral <- pca_comp_1[1:21]
pca_comp_1_baseline <- pca_comp_1[22:42]
pca_comp_1_bacteria <- pca_comp_1[43:52]
pca_comp_2_viral <- pca_comp_2[1:21]
pca_comp_2_baseline <- pca_comp_2[22:42]
pca_comp_2_bacteria <- pca_comp_2[43:52]
pca_comp_3_viral <- pca_comp_3[1:21]
pca_comp_3_baseline <- pca_comp_3[22:42]
pca_comp_3_bacteria <- pca_comp_3[43:52]

# PC 1 vs PC 2
pca_comp_3_bacteria
plot(pca_comp_1_viral,pca_comp_2_viral,col="red",
		xlim=c(min(pca_comp_1), max(pca_comp_1)),
		ylim=c(min(pca_comp_2), max(pca_comp_2)))
points(pca_comp_1_baseline,pca_comp_2_baseline,col="green")
points(pca_comp_1_bacteria,pca_comp_2_bacteria,col="blue")

# PC 1 vs PC 3
quartz()
plot(pca_comp_1_viral,pca_comp_3_viral,col="red",
		xlim=c(min(pca_comp_1), max(pca_comp_1)),
		ylim=c(min(pca_comp_3), max(pca_comp_3)))
points(pca_comp_1_baseline,pca_comp_3_baseline,col="green")
points(pca_comp_1_bacteria,pca_comp_3_bacteria,col="blue")

# PC 2 vs PC 3
quartz()
plot(pca_comp_2_viral,pca_comp_3_viral,col="red",
		xlim=c(min(pca_comp_2), max(pca_comp_2)),
		ylim=c(min(pca_comp_3), max(pca_comp_3)))
points(pca_comp_2_baseline,pca_comp_3_baseline,col="green")
points(pca_comp_2_bacteria,pca_comp_3_bacteria,col="blue")
points(pca_comp_2_bacteria,pca_comp_3_bacteria,col="blue")

