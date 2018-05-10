RNA-seq の簡単なワークフローです

* [平成28年度NGSハンズオン講習会 RNA-seq解析](https://biosciencedbc.jp/gadget/human/20160727_amelieff_20160803.pdf)
に基づいています。

* 使用しているソフトウェア
  * [SeqKit](http://bioinf.shenwei.me/seqkit/)
    * [seqkitを用いたFASTAのフィルタリング・ソート](http://yokazaki.hatenablog.com/entry/2017/01/16/160652)
  * [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
    * [FastQC | FASTQ クオリティコントロール](https://bi.biopapyrus.jp/rnaseq/qc/fastqc.html)
  * [PRINSEQ](http://prinseq.sourceforge.net/)
  * [HISAT2](https://ccb.jhu.edu/software/hisat2/)
    * [hisat2のインデックスファイル](ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/data)
  * [SAMtools](http://www.htslib.org/)
  * [IGV (Integrative Genomics Viewer)](http://software.broadinstitute.org/software/igv)
  * [StringTie](https://ccb.jhu.edu/software/stringtie/)
  * [HTSeq](https://htseq.readthedocs.io/)

* [Ruby](https://www.ruby-lang.org/)
  * [rake](https://docs.ruby-lang.org/ja/latest/library/rake.html)
  * [parallel](https://github.com/grosser/parallel)

## 実行
```bash
rake -T
```
そのままだときちんと動かないのでCPUのコア数、ディレクトリの構成によって適宜スクリプトを書き換える

* シークエンスの状態をチェックする
  * rake seqkit
* FastQC でクオリティチェックを行う
  * rake fastqc_before
* (クオリティコントロール）
  * (rake prinseq)
* (prinseq後のリードの状態をチェックする）
  * (rake seqki2)
* (prinseq後のクオリティをチェックする）
  * (rake fastqc_after)
* Hisat2でマッピングを行う
  * rake hisat2
* sam → bam ファイルの作成とソート
  * rake bam
* IGV(ゲノムブラウザ)で閲覧するためのindexを作成する* 
  * rake index
* StringTie でRNAの配列を数える
  * rake stringtie
* HTSeq でRNAのリード数を数える
  * rake htseq
* HTSeqで得られたカウントを1つのCSVファイルにする
  * rake combine


## 準備
* [Anaconda](https://www.anaconda.com/) を導入する
  * [bioconda](https://bioconda.github.io/)
    * [biocondaを利用してNGS関連のソフトウェアを一括でインストールする](http://imamachi-n.hatenablog.com/entry/2017/01/14/212719)

* hisat2 のインデックスファイル
* GTF ファイル(アノテーション情報）
