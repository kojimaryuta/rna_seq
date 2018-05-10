# HTSeq で RNA のリード数をカウントする

# Ruby でマルチプロセスするためのライブラリ
require 'parallel'

# リファレンス (遺伝子のアノテーション情報) ファイルのパス
# ここでは mm10_gtf (マウス）
# を使用する
GTF_PATH = 'mm10_gtf/Annotation/Genes/genes.gtf'.freeze

# bam ディレクトリ以下の _sorted.bam ファイルを処理
files = Dir.glob('bam/*_sorted.bam').sort

# マルチプロセス並列化
Parallel.each(files, in_processes: 12) do |f|
  base = File.basename(f, '_sorted.bam')
  # コマンド本文
  s = "htseq-count -f bam #{f} #{GTF_PATH} > rep2/#{base}.txt"

  puts s   # 出力
  system s # 実行
end