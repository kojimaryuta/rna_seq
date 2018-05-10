# hisat2 でマッピング

# Rubyでマルチプロセスするためのライブラリ
require 'parallel'

directory "mapping"
desc 'hisat2でマッピング'
task hisat2: "mapping" do
  # ディレクトリ作成

  # 同じディレクトリ内のfastqファイルについて処理を行う
  files = Dir.glob('data/*.fastq').sort

  # AMD RYZEN 16コアでは、2プロセス x 8スレッド が効率的
  Parallel.each(files, in_processes: 2) do |f|
    base = File.basename(f, '.notail.fastq')

    # hisat2 コマンド
    s = "hisat2 -p 8 -x mm10/genome --dta -U #{f} -S mapping/#{base}.sam " \
        "2> mapping/#{base}.txt" # 標準エラー出力をファイル保存

    # コンソールにコマンド出力
    puts s

    # 実行
    system s
  end
end
