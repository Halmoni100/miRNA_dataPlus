# Perform logistic regression
# Load the following...
# 	quantile_norm_data
#	sample_factors

factor_names <- c("viral", "bacterial")
factors <- list(c("v_s", "v_as"), "bc")

m <- nrow(quantile_norm_data)
row_names <- vector(mode="character", length=m)
for (i in 1:m) {
	row_names[i] <- paste("s", i, sep="")
}
rownames(quantile_norm_data) <- row_names

data <- quantile_norm_data[c(19, 20, 32, 86, 93, 111, 141, 165, 191, 199, 200, 201, 209, 211, 329), ]
output <- do_log_reg(data, factors, factor_names, sample_factors)

do_log_reg <- function(data, factors, factor_names, factor_vec) {
# perform logistic regression w/ all but one sample as training set
# data is mxn matrix with m descrbing miRNAs, n describing samples
# Make sure data rows are labeled with names
	create_X_and_y <- dget("R_Code/Classifiers/create_X_and_y.R")
	X_and_y <- create_X_and_y(data, factors, factor_names, factor_vec)
	X <- X_and_y[[1]]
	y <- X_and_y[[2]]
	
	# X is mxn where m describes samples and n describes miRNAs
	m <- nrow(X)
	n <- ncol(X)

	classify_one_out <- dget("R_Code/Classifiers/classify_one_out.R")
	
	classifier_outs <- classify_one_out(X, y, logistic_regression)

	out <- analyze_log_reg_output(X, y, classifier_outs, factor_names)
	
	return(out)
}

logistic_regression <- function(X, y) {
# Perform logistic regression on matrix X with categories specified in y
# X is mxn where m is the # of samples, n is the # of miRNAs
# X must have column names to specify which miRNAs are in the data
# y must only have two categories
# output is output of glm function (logistic regression)
	
	m <- nrow(X)
	n <- ncol(X)
	
	# format data frame for input into glm
	df <- as.data.frame(X)
	feature_names <- colnames(df)
	df <- cbind(df,y)
	
	# create formula
	formula_str <- "y~"
	f1 <- feature_names[1]
	formula_str <- paste(formula_str, f1, sep="")
	for (i in 2:n) {
		f_name <- feature_names[i]
		formula_str <- paste(formula_str, "+", f_name, sep="")
	}
	formula <- as.formula(formula_str)
	# perform glm
	logreg_fit <- glm(formula, family=binomial, data=df)
	return(logreg_fit)
}

analyze_log_reg_output <- function(X, y, classifier_outs, factor_names) {
# X is mxn matrix where m describes samples and n describes miRNAs
	m <- nrow(X)
	n <- ncol(X)
	
	if (m != length(classifier_outs)) {
		stop("# of classifier outputs not equal to # of samples")
	}
	
	# convert y to vector of positives (true) and negatives (false)
	y_positive <- y == factor_names[1]
	
	coef_mat <- matrix( , nrow=28, ncol=n)
	
	# vector of output result compared to actual label
	# key:
	# tp - true positive
	# fp - false positive
	# tn - true negative
	# fn - false negative
	out <- vector(mode="character", length=m)
	for (i in 1:28) {
		print(i)
		data_vec <- X[i, ]
		df_elem <- data.frame(t(data_vec))
		glm.prob <- predict(classifier_outs[[i]], newdata=df_elem, type="response")
		coef_mat[i,] = summary(classifier_outs[[i]])$coefficients[,1]
		positive <- TRUE
		if (glm.prob > .5) {
			positive <- FALSE
		}
		if (positive) {
			if (y_positive[i]) {
				out[i] <- "tp"
			} else {
				out[i] <- "fp"
			}
		} else {
			if (y_positive[i]) {
				out[i] <- "fn"
			} else {
				out[i] <- "tn"
			}
		}
	}
	
	coef_avg <- apply(coef_mat, 2, mean)
	
	return(list(out, coef_avg))
}