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

# Load tree package
library(tree)
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

tree.miRNA <- tree(y~. , data=df_sub)
summary(tree.miRNA)
jpeg("Data_out/decision_tree.jpeg")
plot(tree.miRNA)
text(tree.miRNA, pretty=0)
dev.off()

# Load random forest package
# set seed
set.seed(1)
library(randomForest)
rf.miRNA <- randomForest(y~., data=df_sub, ntree=100, importance=TRUE)
jpeg("Data_out/random_forest_errors.jpeg")
# note: 
plot(rf.miRNA)
legend("top", colnames(rf.miRNA$err.rate),col=1:3,cex=0.8,fill=1:3)
dev.off()
imp.miRNA <- importance(rf.miRNA)
imp.miRNA_ordered <- imp.miRNA[order(imp.miRNA[,4], decreasing=TRUE), ]
write.csv(imp.miRNA_ordered, file="Data_out/importance_gini_ordered.csv")
rnames <- rownames(imp.miRNA_ordered)

# perform random forest w/ different seeds
important_features <- matrix(, nrow=0, ncol=10)
for (i in 100:110) {
	set.seed(i)
	rf.miRNA <- randomForest(y~., data=df_sub, ntree=100, importance=TRUE)
	imp.miRNA <- importance(rf.miRNA)
	imp.miRNA_ordered <- imp.miRNA[order(imp.miRNA[,4], decreasing=TRUE), ]
	rnames <- rownames(imp.miRNA_ordered)
	important_features <- rbind(important_features, rnames[1:10])
}
important_features
 