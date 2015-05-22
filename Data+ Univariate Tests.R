# insert data set
known_miRNAs_expressed_all_samples <- read.delim("~/Desktop/Data+/known_miRNAs_expressed_all_samples.txt", header=TRUE)
View(known_miRNAs_expressed_all_samples)




#subset vector for aaa into virus, healthy & bacteria
virus <- known_miRNAs_expressed_all_samples[1,5:25]
baseline <- known_miRNAs_expressed_all_samples[1,26:46]
bacteria <- known_miRNAs_expressed_all_samples[1,47:56]
infection_status <- c(virus, baseline, bacteria)




#run 1-way anova (completely randomized design)
1anova = lm()



#t-test



#wilcoxin



# run Fisher's F-test if we want
var.test(a,b)


