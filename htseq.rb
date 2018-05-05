require 'parallel'
files = Dir.glob('bam/*_sorted.bam').sort

Parallel.each(files, in_processes: 12) do |f|
  base = File.basename(f, '_sorted.bam')
  s = "htseq-count -f bam #{f} mm10_gtf/Annotation/Genes/genes.gtf > rep2/#{base}.txt"
  puts s
  system s
end
