# IGV(ゲノムブラウザ)で閲覧するためのindexを作成する

# Ruby でマルチプロセスするためのライブラリ
require 'parallel'

# bam ディレクトリ以下の _sorted.bam ファイルを処理
files = Dir.glob('bam/*_sorted.bam').sort

# CPU 16 コア
Parallel.each(files, in_processes: 16) do |f|
  # コマンド
  s = "samtools index #{f}"

  puts s   # コマンド出力
  system s # 実行
end
