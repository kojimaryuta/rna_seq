# sample edgeR script2

#setwd("~/hogehoge")
library("org.Mm.eg.db")

# edgeRの結果を読み込む
files <- list.files(getwd(), pattern="result_.*.csv")
results <- list()

# SYMBOL 2 EG の変換を行う
for (i in 1:length(files)) {
  data <- read.csv(files[i], header=T, row.names=1, sep="\t")
  data <- as.matrix(data)
  genes <- rownames(data)
  ids <- mget(genes, org.Mm.egSYMBOL2EG, ifnotfound = NA)
  ids_c <- as.character(ids)
  data <- cbind(data, EntrezID=ids_c)
  results <- c(results, list(data))
}

# Save CSV file
for (i in 1:length(results)) {
  fname = paste(files[i], "_edger.csv", sep="")
  write.csv(results[i], file=fname)
}

# KEGG Mapper につかうデータを保存
for (i in 1:length(results)) {
  data <- subset(results[[i]], results[[i]][,"PValue"] < 0.2)
  data <- data[,c("EntrezID","logFC")]
  data <- na.omit(data)
  colnames(data) <- c("#mmu", "logFC")
  fname = paste(files[i], ".kegg.txt", sep="")
  write.table(data, file = fname, sep = "\t", quote = FALSE,
              row.names = FALSE)
}
