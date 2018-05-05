require 'parallel'
files = Dir.glob('bam/*_sorted.bam').sort

# 12でプロセス起動するのが最速
Parallel.each(files, in_processes: 12) do |f|
  base = File.basename(f, '_sorted.bam')
  # mm10 gtf
  s = "stringtie -p 2 -G mm10_gtf/Annotation/Genes/genes.gtf -e -o rep/#{base}.gtf -A rep/#{base}.tsv #{f} 2> rep/#{base}.output"
  puts s
  system s
end
