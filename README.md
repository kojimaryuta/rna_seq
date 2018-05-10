RNA-seq の簡単なワークフローです

* [平成28年度NGSハンズオン講習会 RNA-seq解析](https://biosciencedbc.jp/gadget/human/20160727_amelieff_20160803.pdf)
に基づいています。

* 使用しているソフトウェア
  * [SeqKit](http://bioinf.shenwei.me/seqkit/)
    * [seqkitを用いたFASTAのフィルタリング・ソート](http://yokazaki.hatenablog.com/entry/2017/01/16/160652)
  * [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
  * [PRINSEQ](http://prinseq.sourceforge.net/)
  * [HISAT2](https://ccb.jhu.edu/software/hisat2/)
  * [SAMtools](http://www.htslib.org/)
  * [IGV (Integrative Genomics Viewer)](http://software.broadinstitute.org/software/igv)
  * [StringTie](https://ccb.jhu.edu/software/stringtie/)
  * [HTSeq](https://htseq.readthedocs.io/)

* [Ruby](https://www.ruby-lang.org/)
  * [rake](https://docs.ruby-lang.org/ja/latest/library/rake.html)
  * [parallel](https://github.com/grosser/parallel)

実行
```bash
rake -T
```
