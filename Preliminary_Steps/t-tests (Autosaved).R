# load normalized data set


# subset viral, bacterial, baseline, asymptomatic/symptomatic miRNA expression
allviral <- uqnorm[,1:21]
baseline <- uqnorm[,22:42]
bacterial <- uqnorm[,43:52]
viral_symptomatic_vector <- c(1,2,5,9,11,13,15,16,17,18,19,20,21)
viral_asymptomatic_vector <- c(3,4,6,7,8,10,12,14)
viral_symptomatic <- allviral[,viral_symptomatic_vector]
viral_asymptomatic <- allviral[,viral_asymptomatic_vector]
combined_bacterial_baseline <- uqnorm[,22:52]
combined_bacterial_allviral_vector <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,43,44,45,46,47,48,49,50,51,52)
combined_bacterial_allviral <- uqnorm[,combined_bacterial_allviral_vector]
combined_baseline_allviral <- uqnorm[,1:42]



# calculate means of each variable
mean_allviral <- mean(allviral)
mean_bacterial <- mean(bacterial)
mean_baseline <- mean(baseline)
mean_viral_symptomatic <- mean(viral_symptomatic)
mean_viral_asymptomatic <- mean(viral_asymptomatic)



# standard deviation for each variable
sd_allviral <- sd(allviral)
sd_bacterial <- sd(bacterial)
sd_baseline <- sd(baseline)
sd_viral_symptomatic <- sd(viral_symptomatic)
sd_viral_asymptomatic <- sd(viral_asymptomatic)



# conducting a Welch Two Sample t-test on every variable (not assuming equal standard deviation)
test1 <- t.test(allviral,bacterial,alternative="two.sided")
test2 <- t.test(allviral,baseline,alternative="two.sided", paired=TRUE)
# test2 is a paired t-test 
test4 <- t.test(bacterial,baseline,alternative="two.sided")
test5 <- t.test(bacterial,viral_symptomatic,alternative="two.sided")
test6 <- t.test(bacterial,viral_asymptomatic,alternative="two.sided")
test9 <- t.test(combined_bacterial_baseline,allviral,alternative="two.sided")
test10 <- t.test(combined_bacterial_allviral,baseline,alternative="two.sided")
test11 <- t.test(combined_baseline_allviral,bacterial,alternative="two.sided")




# conducting a multiple linear regression model to compare baseline to viral_symptomatic and viral_asymptomatic
symptom <- cbind(viral_symptomatic + viral_asymptomatic)
test7 <- manova(symptom ~ baseline)
boxplot(baseline ~ viral_symptomatic)
boxplot(baseline ~ viral_asymptomatic)




