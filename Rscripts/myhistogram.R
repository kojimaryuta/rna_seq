# ヒストグラムを描出している

result = read.csv("result.csv", row.names=1, header = TRUE)
row = nrow(result)

# HTSeq の統計量を削除
result2 <- result[1:(row-5),]

names <- colnames(result)
for(i in names){
  fname = paste(i, ".png")
  png(fname, width = 600, height = 400)
  hist(result2[,i], main=fname, col="orange", breaks=1000, ylim=c(0,30))
  dev.off()
}