# sample edgeR script1
# 参考：https://bi.biopapyrus.jp/rnaseq/analysis/de-analysis/2g-edger.html

library(edgeR)

#setwd("~/hogehoge")

# CSV ファイルの読み込み
count <- read.csv("result.csv", header = T, row.names = 1)
colnames(count) <- c("A","B","C","D")

# 実際に計算を行う関数
myprocess <- function(count, group, fname) {
  d <- DGEList(counts = count, group = group)
  # 正規化係数の計算
  d <- calcNormFactors(d)
  # 分散の推測
  d <- estimateCommonDisp(d)
  d <- estimateTagwiseDisp(d)
  # exact test による検定
  result <- exactTest(d)

  table <- as.data.frame(topTags(result, n = nrow(count)))
  order(table$PValue)
  # 保存するファイル名の作成
  txtfilename = paste(fname, ".csv", sep="")
  pngfilename = paste(fname, ".png", sep="")
  # 結果をcsv ファイルに保存
  write.table(
    table,
    file = txtfilename,
    col.names = T,
    row.names = T,
    sep = "\t"
  )
  # 解析結果を図示して保存
  # FDR < 0.01 の遺伝子を発現変動遺伝子として赤色でプロット
  is.DEG <- as.logical(table$FDR < 0.01)
  DEG.names <- rownames(table)[is.DEG]
  png(filename=pngfilename)
  plotSmear(result, de.tags = DEG.names)
  dev.off()
}

# サンプルのカウントデータ
count_sample  <- count[,c(1,2,3)]
# 実験群の識別ラベル例
group_sample  <- factor(c("X","X","Y"))
# 実行
myprocess(count_sample, group_sample, "result_sample")
