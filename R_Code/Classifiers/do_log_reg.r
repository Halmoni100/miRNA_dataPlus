do_log_reg = function(df_sub, type, dir) {
# Performs logistic regression on the data frame df_sub
# Arguments:
# df_sub - data frame; column y (the last column) represents response
# type - integer describing regularization; 0 for ridge, 1 for lasso
# dir - directory to save results

	# Load glmnet
	library(glmnet)
	
	# get nrow (m) and ncol (n) of X, the matrix without the response
	m = nrow(df_sub)
	n = ncol(df_sub) - 1
	
	# define X as the matrix without the response
	X = data.matrix(df_sub[ ,1:n])
	# define y as the response
	y = df_sub$y

	# Check order of categories, print out
	factor_order = levels(y)
	write.table(factor_order, file=paste(dir, "factor_order.txt", sep=""), sep="\t",
			 quote=FALSE, col.names=FALSE)
	# Do leave one out cross validation
	cv.out = cv.glmnet(X, y, family="binomial",
			type.measure="class", alpha=1, nfolds=m)
	
	# Plot misclassification rates from LOOCV vs lambda parameter
	jpeg(paste(dir, "loocv_misclassification_rates.jpeg", sep=""))
	plot(cv.out)
	dev.off()
	
	# Choose best lambda from LOOCV
	bestlam = cv.out$lambda.min
	
	# Do lasso logistic regression on all of the data using best lambda
	lasso.mod = glmnet(X, y, family="binomial", alpha=type)
	lasso.coef = predict(lasso.mod, type="coefficients", s=bestlam)
	
	# Print out coefficients
	indices = rownames(lasso.coef)
	nonzero_coef = matrix(, nrow=0, ncol=2)
	colnames(nonzero_coef) = c("index", "coef")
	for (i in 2:length(lasso.coef)) {
		if (abs(lasso.coef[i]) > 0) {
			feat_string = indices[i]
			index_string = substring(feat_string, 2)
			index = as.integer(index_string)
			new_coef = c(index, lasso.coef[i])
			nonzero_coef = rbind(nonzero_coef, new_coef)
		}
	}
	nonzero_coef_df = as.data.frame(nonzero_coef)
	lr_nonzero_coef_sorted = nonzero_coef_df[order(-abs(nonzero_coef_df$coef)),]
	rownames(lr_nonzero_coef_sorted) = NULL
	write.table(lr_nonzero_coef_sorted, file=paste(dir, "coefs.txt", sep=""), sep="\t",
			row.names=FALSE)
			
	# Do LOOCV manually, plot ROC curve
	# http://stackoverflow.com/questions/18292419/how-to-obtain-auc-using-leave-one-out-cross-validation-in-r
	# get predictions for each sample left out in LOOCV
	predictions = c()
	for (i in 1:m) {
		model = glmnet(X[-i,], y[-i], family="binomial")
		new_x = matrix(X[i,], nrow=1, ncol=n)
		predictions <- c(predictions, predict(model, newx=new_x, s=cv.out$lambda.min))
	}
	# Plot ROC curve
	library(pROC)
	jpeg(paste(dir, "roc_curve.jpeg", sep=""))
	bin_comp.loocv_roc = roc(y, predictions)
	plot(bin_comp.loocv_roc)
	dev.off()
	
	# Get AUC
	bin_comp.auc = auc(bin_comp.loocv_roc)
	roc_set = list(y, predictions, bin_comp.auc)
	return(roc_set)
}

