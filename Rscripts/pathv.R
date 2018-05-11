# sample edgeR script3

#setwd("~/hogehoge")

library("pathview")

# next.R で作成したcsvファイルを読み込む
files <- list.files(getwd(), pattern="*csv_edger.csv")

for (i in 1:length(files)) {
  data <- read.csv(files[i], header=T, row.names=1)
  data <- subset(data, data$PValue<0.3)
  data <- data[,c("EntrezID", "logFC")]
  data <- na.omit(data)
  gene.id <- as.numeric(data$logFC)
  names(gene.id) <- as.character(data$EntrezID)
  p.ids <- c("00000","00001","00002")
  for (j in p.ids) {
  pv <- pathview(gene.data = gene.id, pathway.id = j,
                 out.suffix = files[i], species = "mmu")
  }
}
