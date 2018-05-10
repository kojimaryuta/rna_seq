# HTSeq で得られたカウントデータを1つのCSVファイルにまとめる

# Ruby で CSV をあつかうためのライブラリ
require 'csv'

desc 'HTSeq で得られたカウントデータを1つのCSVファイルにまとめる'
task :combine do
  # ファイル名でソート（適宜書き換え）
  files = Dir.glob('htseq/*.fastq.txt').sort_by { |f| f[13..14].to_i }

  data = [['geneid']]

  # 1番目のファイルから gene id をdataに入れる
  # すべてのCSVファイルの gene id が同じようについている前提
  File.open(files[0]) do |f|
    f.each_line do |l|
      data << [l.split("\t")[0]]
    end
  end

  # それぞれのファイルの1列をdataに入れる
  files.each do |fname|
    data[0] << File.basename(fname, '.fastq.txt')
    File.open(fname) do |f|
      f.each_line.with_index(1) do |l, index|
        data[index] << l.split("\t")[1].chomp
      end
    end
  end

  # CSV ファイルに書き込む
  CSV.open('htseq/result.csv', 'wb') do |csv|
    data.each do |d|
      csv << d
    end
  end
end
