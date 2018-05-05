require 'parallel'

files = Dir.glob('bam/*_sorted.bam').sort

Parallel.each(files, in_processes: 16) do |f|
  s = "samtools index #{f}"
  puts s
  system s
end
