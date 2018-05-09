# シークエンスの状態をチェックする
seqkit stat *.fastq

# qc2 フォルダを作成する
mkdir qc2

# クオリティコントロール
ruby qc2.rb

# mapping フォルダを作成する
mkdir mapping

# マッピングを行う
ruby hisat.rb

# bam フォルダを作成する
mkdir bam

# SAM -> BAM 変換し、Sortする
ruby bam.rb

# IGV(ゲノムブラウザ)で閲覧するためのindexを作成する
ruby index.rb

# rep フォルダを作成する
mkdir rep

# StringTie でRNAの配列を数える
ruby stringtie.rb

# rep2 フォルダを作成する
mkdir rep2

# htseq でRNAのリード数を数える
ruby htseq.rb

# htseq で出力されたデータをひとつのCSVファイルにまとめる
ruby combine.rb
