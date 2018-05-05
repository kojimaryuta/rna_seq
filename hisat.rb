require "parallel"

files = Dir.glob("*.fastq").sort

Parallel.each(files, in_processes:2) do |f|
  base = File.basename(f, ".notail.fastq")
  s = "hisat2 -p 8 -x mm10/genome --dta -U #{f} -S mapping/#{base}.sam 2> mapping/#{base}.txt" 
  puts s
  system s
end
