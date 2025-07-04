library(lmerTest)
df2 <- read.table("input.txt",header = T,row.names=1,sep = "\t")
df <- data.frame(t(df2))
df$Type <- as.factor(df$Type)
df$Group <- as.factor(df$Group)
expA <- subset(df,Type=="A")
expB <- subset(df,Type=="B")
for (i in 1:(ncol(df)-5)) {
  exp_i <- df[,i]
  exp_i <- as.data.frame(exp_i)
  colnames(exp_i)[1] <- "Gene"
  fit <- lmer(as.numeric(exp_i$Gene) ~  Type + as.numeric(df$PC1) + as.numeric(df$PC2) + as.numeric(df$PC3) + (1|Group),data=df)
  expA_mean <- mean(as.numeric(expA[,i]))
  expB_mean <- mean(as.numeric(expB[,i]))
  FC <- expB_mean / expA_mean
  DEGs_pvalue <- paste(colnames(df)[i],FC,expA_mean,expB_mean,anova(fit)[1,6],sep = "&")
  print(DEGs_pvalue)
}
