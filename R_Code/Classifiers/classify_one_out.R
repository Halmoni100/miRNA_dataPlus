classify_one_out <- function(X, y, classifier) {
# apply classification algorithm...
# X is mxn matrix where m describes samples and n describes miRNAs
# - make sure X has column names to specify miRNAs
# y is vector of labels for samples
# training set is all but one sample
# the one sample is cross validation sample
# leave one out in training set for all samples
# return...
# - list of the results of the classifiers created

	m <- nrow(X)
	n <- ncol(X)

	classifier_outs <- list()

	for (i in 1:m) {
		training_X <- X[-i, ]
		training_y <- y[-i]
		classifier_outs[[i]] <- classifier(training_X, training_y)
	}
	
	return(classifier_outs)
}