args<-commandArgs(T)
setwd(args[1])
library(lmerTest)
df <- read.table("./input.txt",header = T,sep = "\t")
mod_1 <- lm(TPM ~  1 + Type + Q1 + Q2 + Q3 + Q4 + Q5 + P1 + P2 + P3 + P4 + P5 + P6 + P7 + P8 + P9 + P10,data=df)
mod_2 <- lm(TPM ~  1 + Q1 + Q2 + Q3 + Q4 + Q5 + P1 + P2 + P3 + P4 + P5 + P6 + P7 + P8 + P9 + P10,data=df)
x1 <- summary(mod_1)$r.squared
x2 <- summary(mod_2)$r.squared
pve <- x1-x2
s <- summary(mod_1)
TWAS_pvalue <- paste(anova(mod_1)[1,5],pve,sep = "&")
print(TWAS_pvalue)
