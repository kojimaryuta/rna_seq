require "csv"

files = Dir.glob("rep2/*.fastq.txt").sort_by{|f| f[13..14].to_i}

data = [["geneid"]]

File.open(files[0]) do |f|
  f.each_line do |l|
    data << [l.split("\t")[0]]
  end
end

files.each do |fname|
  data[0] << File.basename(fname, ".fastq.txt")
  File.open(fname) do |f|
    f.each_line.with_index(1) do |l,index|
      data[index] << l.split("\t")[1].chomp
    end
  end
end

CSV.open("rep2/result.csv", "wb") do |csv|
  data.each do |d|
    csv << d
  end
end
