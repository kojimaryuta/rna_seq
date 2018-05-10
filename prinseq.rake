# prinseq-lite でクオリティコントロール

require 'parallel'

# ディレクトリ内のfastqファイルについて操作
files = Dir.glob('*.fastq').sort

Parallel.each(files, in_proesses: 8) do |f|
  base = File.basename(f, '.fastq')

  # prinseq-lite コマンド
  # オプションはアメリエフ資料と同じにしてるだけ
  s = "prinseq-lite.pl -fastq #{f} " \
      "-out_good qc2/#{base}.notail " \
      "-out_bad qc2/#{base}.bad " \
      '-out_format 3 ' \
      '-trim_left 5 ' \
      '-trim_tail_right 5 ' \
      '-trim_qual_right 30 ' \
      '-ns_max_p 20 ' \
      '-min_len 30 ' \
      "2> qc2/#{base}.txt" # 標準エラー出力をファイルに保存

  # コンソールへコマンド出力
  puts s

  # 実行
  system s
end