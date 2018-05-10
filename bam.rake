# sam → bam ファイルの作成とソート

# Ruby でマルチプロセスするためのライブラリ
require 'parallel'

desc 'sam → bam ファイルの作成とソート'
task :bam do
  # ディレクトリの作成
  directory 'bam'

  # mappingディレクトリ以下の、samファイルを操作
  files = Dir.glob('mapping/*.sam').sort.map do |f|
    base = File.basename(f, '.sam')
  end

  # CPU 16コアで、4プロセス x 4スレッド 並列化
  Parallel.each(files, in_processes: 4) do |f|
    # コマンド本文 bam ファイル変換
    s = "samtools view -@ 4 -b mapping/#{f}.sam > bam/#{f}.bam"

    puts s   # 出力
    system s # 実行
  end

  # CPU 16コアで、4プロセス x 4スレッド 並列化
  Parallel.each(files, in_processes: 4) do |f|
    # コマンド本文 bam ファイルソート
    s = "samtools sort -@ 4 bam/#{f}.bam -o bam/#{f}_sorted.bam"

    puts s   # 出力
    system s # 実行
  end
end
