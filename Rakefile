# fastq ファイルと同じディレクトリで実行するものとする

desc "シークエンスの状態をチェックする"
task :seqkit do
  sh "seqkit stat *.fastq | tee seqkit.txt"
end

desc "FastQCでクオリティチェックを行う"
task :fastqc_before do
  directory "fastqc_before"
  sh "fastqc --nogroup -t 16 -o fastqc_before *.fastq" 
end

# PRINSEQでクオリティコントロール
load './prinseq.rake'

desc "QC後のシークエンスの状態をチェックする"
task :seqkit2 do
  sh "seqkit stat qc2/*.fastq | tee seqkit2.txt"
end

desc "QC後のクオリティチェックを行う"
task :fastq_after do
  directory "fastqc_after"
  sh "fastqc --nogroup -t 16 -o fastqc_after qc2/*.notail.fastq"
end

# マッピングを行う
load './hisat2.rake'

# SAM -> BAM 変換し、Sortする
load './bam.rake'

# IGV(ゲノムブラウザ)で閲覧するためのindexを作成する
load './index.rake'

# StringTie でRNAの配列を数える
load './stringtie.rake'

# htseq でRNAのリード数を数える
load './htseq.rake'

# htseq で出力されたデータをひとつのCSVファイルにまとめる
load './combine.rake'
