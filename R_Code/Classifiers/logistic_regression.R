# Load the following...
# df (from data_frames.r)
# sample_factors

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
factor_names <- c("G1", "G2")
# get df_sub
df_sub <- create_df_sub(df, sample_factors, factors, factor_names)

# get nrow (m) and ncol (n) of df
m <- nrow(df_sub)
n <- ncol(df_sub)

set.seed(1)
grid=10^seq(10,-2,length=100)

print(head(df_sub))

y <- as.integer(df_sub[,n])
y <- y-1
y
lasso.mod = glmnet(as.matrix(df_sub[,1:n-1]), y, alpha=1, lambda=grid)
cv.out=cv.glmnet(as.matrix(df_sub[,1:n-1]), y, alpha=1, nfolds=m)
plot(cv.out)

lasso.coef = predict(lasso.mod, type="coefficients", s=bestlam)


