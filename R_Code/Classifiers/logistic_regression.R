# Load the following...
# df (from data_frames.r)
# sample_factors
load("Data_in/data_frames.r")
load("Data_in/saved_sample_factors.r")

# For reference:
# Viral Symptomatic - v_s
# Viral Asymptomatic - v_as
# Baseline Symptomatic - bl_s
# Basline Asymptomatic - bl_as
# Bacteria - bc

# Load glmnet
library(glmnet)
# Load create_df_sub function
create_df_sub <- dget("R_Code/Classifiers/create_df_sub.r")

# test...
# try on viral symptomatic vs bacteria
# create factors and factor_names
grp1 <- "v_s"
grp2 <- "bc"
factors <- list(grp1, grp2)
factor_names <- c("Viral Symptomatic", "Bacteria")
# get df_sub
df_sub <- create_df_sub(df, sample_factors, factors, factor_names)

# get nrow (m) and ncol (n) of df_sub
m <- nrow(df_sub)
n <- ncol(df_sub)

print(str(df_sub$y))

# Perform lasso logistic regression on all of the data
grid = 10^seq(10, -2, length=100)
lasso.mod = glmnet(as.matrix(df_sub[,1:n-1]), df_sub$y, family="binomial", alpha=1)

# Do leave one out cross validation
cv.out = cv.glmnet(as.matrix(df_sub[,1:n-1]), df_sub$y, family="binomial", type.measure="class", alpha=1, nfolds=m)
# Plot misclassification rates from LOOCV vs lambda parameter
plot(cv.out)
# Choose best lambda from LOOCV
bestlam = cv.out$lambda.min

# Do lasso logistic regression on all of the data using best lambda
lasso.coef = predict(lasso.mod, type="coefficients", s=bestlam)

# Print out coefficients
indices <- rownames(lasso.coef)
nonzero_coef <- matrix(, nrow=0, ncol=2)
colnames(nonzero_coef) <- c("index", "coef")
for (i in 2:length(lasso.coef)) {
	if (abs(lasso.coef[i]) > 0) {
		print(i)
		print(lasso.coef[i])
		feat_string <- indices[i]
		index_string <- substring(feat_string, 2)
		index <- as.integer(index_string)
		new_coef <- c(index, lasso.coef[i])
		nonzero_coef <- rbind(nonzero_coef, new_coef)
	}
}
nonzero_coef_df <- as.data.frame(nonzero_coef)
lr_nonzero_coef_sorted <- nonzero_coef_df[order(-abs(nonzero_coef_df$coef)),]
rownames(lr_nonzero_coef_sorted) <- NULL
write.table(lr_nonzero_coef_sorted, file="Data_out/logistic_regression_coefs.txt", sep="\t", row.names=FALSE)