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
git clone して、dataフォルダを作成し、内部にfastqファイルを配置する。
```bash
├── README.md
├── Rakefile
├── bam.rake
├── combine.rake
├── config.rb
├── data
│   ├── sample1.fastq
│   └── sample2.fastq
├── hisat2.rake
├── htseq.rake
├── index.rake
├── prinseq.rake
└── stringtie.rake
```
Rakeタスクの表示
```bash
rake -T
```
そのままだときちんと動かないのでCPUのコア数、ディレクトリの構成によって適宜スクリプトを書き換える

```console
rake seqkit         # シークエンスの状態をチェックする

rake fastqc_before  # FastQCでクオリティチェックを行う

rake prinseq        # prinseq-lite でクオリティコントロール

rake seqkit2        # QC後のシークエンスの状態をチェックする

rake fastqc_after   # QC後のクオリティチェックを行う

rake hisat2         # hisat2でマッピング

rake bam            # sam → bam ファイルの作成とソート

rake index          # IGV(ゲノムブラウザ)で閲覧するためのindexを作成する

rake stringtie      # StringTie でRNAの配列を数える

rake htseq          # HTSeq で RNA のリード数をカウントする

rake combine        # HTSeq で得られたカウントデータを1つのCSVファイルにまとめる
```

## 準備
* [Anaconda](https://www.anaconda.com/) を導入する
  * [bioconda](https://bioconda.github.io/)
    * [biocondaを利用してNGS関連のソフトウェアを一括でインストールする](http://imamachi-n.hatenablog.com/entry/2017/01/14/212719)

* hisat2 のインデックスファイル
* GTF ファイル(アノテーション情報）

## TODO
* MultiQC 
