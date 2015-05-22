# insert data set
known_miRNAs_expressed_all_samples <- read.delim("~/Desktop/Data+/known_miRNAs_expressed_all_samples.txt", header=TRUE)
View(known_miRNAs_expressed_all_samples)



# remove all non-normalized sample columns
known_miRNAs_expressed_all_samples[57:108] <- list(NULL)



#subset vector for aaa into virus, healthy & bacteria
aaa_norm_subset <- known_miRNAs_expressed_all_samples[1]
v <- aaa_norm_subset[,5:25]
h <- aaa_norm_subset[,26:46]
b <- aaa_norm_subset[,47:56]

#run 1-way anova (completely randomized design)
fit <- aov(y ~ A, data=aaa_norm_subset)

# run Fisher's F-test if we want
var.test(a,b)


