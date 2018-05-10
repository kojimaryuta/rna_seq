# StringTie でRNAの配列を数える

GTF_PATH = 'mm10_gtf/Annotation/Genes/genes.gtf'.freeze

# Ruby でマルチプロセスするためのライブラリ
require 'parallel'

desc 'StringTie でRNAの配列を数える'
task :stringtie do

  # ディレクトリの作成
  directory "stringtie"

  # bam ディレクトリ以下の _sorted.bam ファイルを処理
  files = Dir.glob('bam/*_sorted.bam').sort

  # プロセス数は適宜調節
  # ここでは 12プロセス x 2 スレッド
  Parallel.each(files, in_processes: 12) do |f|
    base = File.basename(f, '_sorted.bam')
    # コマンド本文
    s = 'stringtie -p 2 '                + # -p スレッド数
        "-G #{GTF_PATH} -e "             + # -G リファレンスの指定
        "-o stringtie/#{base}.gtf "      + # -o 出力ファイルの指定
        "-A stringtie/#{base}.tsv #{f} " + # -A gene abundance estimation の出力ファイル
        "2> stringtie/#{base}.output"      # 標準エラー出力をファイルに保存

    # コマンド出力
    puts s

    # 実行
    system s
  end
end
