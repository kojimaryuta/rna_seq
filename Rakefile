# fastq ファイルと同じディレクトリで実行するものとする
load './config.rb'

desc "シークエンスの状態をチェックする"
task :seqkit do
  sh "seqkit stat data/*.fastq | tee seqkit.txt"
end

desc "FastQCでクオリティチェックを行う"
directory "fastqc_before"
task :fastqc_before do
  sh "fastqc --nogroup -t 8 -o fastqc_before data/*.fastq" 
end

# PRINSEQでクオリティコントロール
load './prinseq.rake'

desc "QC後のシークエンスの状態をチェックする"
task :seqkit2 do
  sh "seqkit stat prinseq/*.fastq | tee seqkit2.txt"
end

desc "QC後のクオリティチェックを行う"
directory "fastqc_after"
task :fastqc_after do
  sh "fastqc --nogroup -t 8 -o fastqc_after prinseq/*.notail.fastq"
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
