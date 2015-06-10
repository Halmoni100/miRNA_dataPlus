# Retrieve Data
# quantile_norm_data retrieved
load("R_data/saved_quantile_norm_data")

# Do PCA Analysis
pca_analysis <- dget("Preliminary_Steps/PCA/analyze_PCs_samples.r")
pca_analysis(quantile_norm_data, 10)