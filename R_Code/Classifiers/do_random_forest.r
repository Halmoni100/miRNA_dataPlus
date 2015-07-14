do_random_forest = function(df_sub, num_trees, seed, dir) {
# Perform random forest function on the data frame df_sub
# Arguments:
# df_sub - data frame; column y (the last column) represents response
# num_trees - number of trees in random forest
# seed - set seed for random number generator used in randomForest package
# dir - directory to save results
	
	# Load randomForest
	library(randomForest)
	
	# set random num generator seed
	set.seed(seed)
	
	# make random forest
	rf.miRNA = randomForest(y~., data=df_sub, ntree=num_trees, importance=TRUE)
	
	# plot error rates
	jpeg(paste(dir, "rf_errors.jpeg", sep=""))
	plot(rf.miRNA)
	legend("top", colnames(rf.miRNA$err.rate), col=1:3, cex=0.8, fill=1:3)
	dev.off()
	
	# get importance for miRNAs by gini index
	imp.miRNA <- importance(rf.miRNA)
	imp.miRNA_ordered <- imp.miRNA[order(imp.miRNA[,4], decreasing=TRUE), ]
	write.csv(imp.miRNA_ordered, file=paste(dir, "importance_gini_ordered.csv"))
}