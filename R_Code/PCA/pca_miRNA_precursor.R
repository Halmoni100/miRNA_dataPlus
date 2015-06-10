# Read quantile normalized data
# quantile_norm_data retrieved
load("R_data/saved_quantile_norm_data")

# Read content table w/ sequence data for miRNA & precursor
miRNA_seq_df <- read.delim("Preliminary_Steps/sequence_content/content_table_miRNA.txt")
prec_seq_df <- read.delim("Preliminary_Steps/sequence_content/content_table_precursor.txt")

# Create lists for gc proportion and lengths for miRNA & precursor
miRNA_gc_prop <- miRNA_seq_df$gc_prop
prec_gc_prop <- prec_seq_df$gc_prop
miRNA_length <- miRNA_seq_df$length
prec_length <- prec_seq_df$length

# Do PCA Analysis for all variables
pca_analysis <- dget("Preliminary_Steps/PCA/analyze_PCs_miRNA_precursor.r")
pca_analysis(quantile_norm_data, miRNA_length, miRNA_gc_prop,
		prec_length, prec_gc_prop, 3)


