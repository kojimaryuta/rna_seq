require "parallel"

files = Dir.glob("mapping/*.sam").sort.map do |f|
  base = File.basename(f, ".sam")
end

Parallel.each(files, in_processes:4) do |f|
  s = "samtools view -@ 4 -b mapping/#{f}.sam > bam/#{f}.bam"
  puts s
  system s
end

Parallel.each(files, in_processes:4) do |f|
  s = "samtools sort -@ 4 bam/#{f}.bam -o bam/#{f}_sorted.bam"
  puts s
  system s
end
