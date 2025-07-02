args<-commandArgs(T)
setwd(args[1])
df <- read.table("./dist_input.txt",header = T,sep = "\t",row.names = 1)
d <- dist(df,method = "euclidean")
d
