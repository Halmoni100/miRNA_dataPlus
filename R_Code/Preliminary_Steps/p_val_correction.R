load("R_Data/saved_p_vals.r")
load("R_Data/saved_conf_ints_p_vals.r")
load("R_Data/data_frames.r")

# create list of data frames
significant_miRNAs = list()
# get miRNA names
names = feat_df$miRNA
# compute Bonferroni p-values
# returns data frame of index, p value, and confidence interval
bonferroni_adjust = function(test_num, p_vals) {
	# get p vals for particlar test number
	p_val_vec = p_vals[test_num, ]
	# apply bonferroni correction
	adjusted_p_val_vec = p.adjust(p_val_vec, method = "bonferroni")
	# initialize dataframe for significant p values
	significant = data.frame(index=NA, name=NA, p_val=NA, conf_int=NA)
	# add to data frame if p value is significant
	for (i in 1:length(adjusted_p_val_vec)) {
		val = adjusted_p_val_vec[i]
		if (val <= .05) {
			conf_int = conf_ints[test_num, i]
			name = as.character(names[i])
			entry = c(i, name, val, conf_int)
			significant = rbind(significant, entry)
		}
	}
	# remove NA initialization row
	significant = significant[-1, ]
	# order data frame by adjusted p value
	significant_ordered = significant[order(significant$p_val), ]
	
	return(significant_ordered)
}

# get number of rows, or number of tests (binary comparisons) conducted
n = nrow(p_vals)

# perform function for each column
# save to txt file
# create images when necessary
dir.create("Results/t_test_p_value_plots")
for (i in 1:n) {
	adjusted_p_vals = bonferroni_adjust(i, p_vals)
	significant_miRNAs[[i]] = adjusted_p_vals
	if (nrow(adjusted_p_vals) > 0) {
		postscript(file=paste("Results/t_test_p_value_plots/sig_miRNRA_test_", i, ".eps", sep=""), width=5, height=5)
		bar_plot_p_values = as.numeric(adjusted_p_vals$p_val)
		bar_plot_names = adjusted_p_vals$index
		barplot(height=bar_plot_p_values, names.arg=bar_plot_names, las=1)
		dev.off()
	}
}
save(significant_miRNAs, file="R_Data/saved_significant_miRNAs.r")
print(significant_miRNAs)

# compute FDR p-values, order them in data frame
fdr_adjust = function(test_num) {
	p_val_vec = p_vals[, test_num]
	adjusted_p_val_vec = p.adjust(p_val_vec, method = "fdr")
	significant_mat = matrix(, nrow=0, ncol=3)
	for (i in 1:length(adjusted_p_val_vec)) {
		val = adjusted_p_val_vec[i]
		if (val <= .05) {
			conf_int = conf_ints[i, test_num]
			entry = c(i, val, conf_int)
			significant_mat = rbind(significant_mat, entry)
		}
	}
	significant = as.data.frame(significant_mat)
	colnames(significant) = c("index", "p_val", "conf_int")
	significant_ordered = significant[order(significant$p_val), ]
	return(significant_ordered)
}

# Do FDR?
do_fdr = FALSE 
if (do_fdr){
	# compute false discovery rates (less conservative method than the bonferroni correction)
	fdr_significant_miRNAs = list()
	# perform function for each column
	for (i in 1:7) {
		fdr_significant_miRNAs[[i]] = fdr_adjust(i)
	}

	head(fdr_significant_miRNAs[[i]]$p_val)
	# extract data frame out of the list
	for (i in 1:7) {
		new_frame = fdr_significant_miRNAs[[i]]
		if (nrow(new_frame) > 0) {
			adjusted_fdr_pvals = new_frame$p_val
			quartz()
			plot_name = paste("Test #", i)
			hist(adjusted_fdr_pvals, main = plot_name)
		}
	}
}