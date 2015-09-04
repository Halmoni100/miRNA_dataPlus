coef_in = read.csv("Data_in/log_reg_coefs.csv")

coef_df = coef_in[,2:4]
comps = as.vector(coef_in[,1])
row.names(coef_df) = comps
coef_df = t(coef_df)
coef_df = as.data.frame(coef_df)

coefs = table(coef_df$"VS_vs_BLS", coef_df$"VS_vs_BC", coef_df$"BC_vs_BL")
barplot(coefs, main="Logistic Regression Coef (abs val)")

