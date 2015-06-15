# Load the following...
# quantile_norm_data

# Do PCA Analysis
pca_analysis <- dget("R_Code/PCA/analyze_PCs_samples.r")
pca_analysis(quantile_norm_data, 10)