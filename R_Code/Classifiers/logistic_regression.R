# Load the following...
# bin_comp_dfs
# bin_comp_names
# feat_df (from data_frames.r)

# Loading do_log_reg func
do_log_reg = dget("R_Code/Classifiers/do_log_reg.r")

# create main directory
dir.create("Data_out/logistic_regression_out")
main_dir = "Data_out/logistic_regression_out/"

# Obtain data for roc curves
return_data = list()

# Initialize misclassification rate vector
log_reg_misclass_rates = vector(length=7)

# Do logistic regression for each binary comparison
for (i in 1:7) {
	# get df_sub
	df_sub = bin_comp_dfs[[i]]
	# create directory
	dir.create(paste(main_dir, bin_comp_names[i], sep=""))
	# perform logistic regression
	sub_dir = paste(bin_comp_names[i], "/", sep="")
	return_data[[i]] = do_log_reg(df_sub, 1, paste(main_dir, sub_dir, sep=""), feat_df)
	# retrieve misclassification rate
	log_reg_misclass_rates[i] = return_data[[i]][[4]]
}


# Record misclassification rates, both csv and r data
write.csv(cbind(bin_comp_names, log_reg_misclass_rates), file=paste(main_dir, "misclass_rates.csv", sep=""), row.names=FALSE)
save(log_reg_misclass_rates, file=paste(main_dir, "saved_log_reg_misclass_rates.r", sep=""))
# Make bar plot
postscript(paste(main_dir, "misclass_bar_plot.eps", sep=""), width=7, height=6)
par(mar=c(3,15,3,3), las=2)
title(col.sub="white")
barplot(log_reg_misclass_rates, names.arg=gsub("_", " ", bin_comp_names), horiz=TRUE, col="blue")
dev.off()

# Plot ROC curves
library(pROC)
postscript(paste(main_dir, "roc_curves_combined.eps", sep=""), width=7, height=6)
bin_comps_to_plot = c(1, 4, 6)
titles = c("Viral Symp vs. Baseline Symp", "Viral Symp vs. Bacteria", "Bacteria vs. Baseline")
num_bin_comps = length(bin_comps_to_plot)
plot_colors = c("blue", "red", "green")
# plot 1st ROC curve
bin_comp_num = bin_comps_to_plot[1]
roc_set = return_data[[bin_comp_num]]
bin_comp.loocv_roc = roc(roc_set[[1]], roc_set[[2]])
plot(bin_comp.loocv_roc, col=plot_colors[1], axes=TRUE)
# plot other ROC curves
for (i in 2:num_bin_comps) {
	bin_comp_num = bin_comps_to_plot[i]
	roc_set = return_data[[bin_comp_num]]
	bin_comp.loocv_roc = roc(roc_set[[1]], roc_set[[2]])
	plot(bin_comp.loocv_roc, add=TRUE, col=plot_colors[i], axes=TRUE)
}
# get auc values
auc_vals = vector(length=num_bin_comps)
for (i in 1:num_bin_comps) {
	bin_comp_num = bin_comps_to_plot[i]
	auc_vals[i] = return_data[[bin_comp_num]][[3]]
}
# merge titles and auc values
legend_titles = vector(length=num_bin_comps)
for (i in 1:3) {
	legend_titles[i] = paste(titles[i], "   AUC: ", signif(auc_vals[i], digits=4), sep="")
}
# plot legend
legend = legend(x=.7, y=0.2, legend=legend_titles, fill=plot_colors)

dev.off()