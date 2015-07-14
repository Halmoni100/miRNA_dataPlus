# Load the following...
# uqnorm_data
# sample_factors
# feat_df (from data_frames.r)

# function to log transform the data
log_transform = function(x) {
	return log(x + 1)
}

# log the data, transform it, make it into data frame
logged_data = apply(uqnorm_data, c(1,2), log_transform)
logged_data = t(logged_data)
logged_df = as.data.frame(logged_data)

# important miRNA indices:
# - 200
# - 86
# - 195
# - 211
# - 51

# extract miRNAs
miRNA_indices = c(200, 86, 195, 211, 51)
# extract miRNA names from feat_df
miRNA_names = feat_df$miRNA[miRNA_indices]
select_logged_df = logged_df[ , miRNA_indices]

# important subgroups:
# - bacteria
# - baseline symptomatic
# - baseline asymptomatic
# - viral symptomatic

# For reference:
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline Symptomatic - bl_s
# Basline Asymptomatic - bl_as
# Bacteria - bc

# subgroups
sub_grps = c("bc", "v_s", "bl_s", "bl_as")
sub_grp_names = c("BC", "V Symp", "BL Symp", "BL Asymp")
num_grps = length(sub_grps)

# aggregate data for miRNA for use in box plots
# define miRNA_df as list of lists; for each miRNA, then for each group, vector of counts
miRNA_list = list()
num_miRNAs = length(miRNA_indices)
for (i in 1:num_miRNAs) {
	miRNA_index = miRNA_indices[i]
	index_data = select_logged_df[ , i]
	grp_list = list()
	for (j in 1:num_grps) {
		ct_vec = index_data[sample_factors == sub_grps[j]]
		grp_list[[j]] = ct_vec
	}
	miRNA_list[[i]] = grp_list
}


# select only certain miRNA indices
# make boxplots
postscript("Data_out/miRNA_distributions.eps", width=11.5, height=8)
# divide figure into 6 cells
par(mfrow=c(2,3))
col_scheme = c("red", "green", "blue", "orange")
for (i in 1:num_miRNAs) {
	miRNA_name = miRNA_names[i]
	miRNA_num = miRNA_indices[i]
	plot_title = paste(miRNA_name, " (index #", miRNA_num, ")", sep="")
	boxplot(miRNA_list[[i]], main=plot_title, col=col_scheme, names=sub_grp_names)
}
dev.off()