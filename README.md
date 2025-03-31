# Camptotheca single cell
Repository for Camptotheca single cell omics manuscript 

## Leaf single nuclei RNA-seq analysis (10x Genomics Multiome)

* `caa_multi_10x_cutadapt.sh` removes adapter sequences.
* `caa_multi_10x_pair_cleaned_reads.sh` restores reads pairing.
* `caa_multi_10x_starsolo_*.sh` use [starsolo](https://github.com/alexdobin/STAR/blob/master/docs/STARsolo.md) to generate cell/gene matrix.
* `caa_multi_GEX_stringent.Rmd` filters nuclei and generates visualizations.

## Leaf single nuclei ATAC-seq analysis (10x Genomics Multiome)

* `cellranger-arc_count_CAA_*.sh` use [cellranger arc](https://www.10xgenomics.com/support/software/cell-ranger-arc/latest) to generate fragment files.
* `Caa_ATAC_preprocessing.Rmd` filters nuclei and integrate with RNA-seq assay.
* `Deeptools.sh` calculates coverage from ATAC data.
* `Deeptools_matrix.sh` caculates coverage at genes or peaks for visualization.
* `Motif_enrichment_.Rmd` finds marker peaks.
* `MEME_top_peaks.sh` uses [MEME](https://meme-suite.org/meme/) to find overrepresented motifs.

## Stem single cell RNA-seq (Fluent BioSciences PIPseq)

* `caa_stem_pip_starsolo_*.sh` uses [starsolo](https://github.com/alexdobin/STAR/blob/master/docs/STARsolo.md) to generate cell/gene matrix.
* `caa_stem_pip.Rmd` filters cells and generates visualizations.
* `mafft_*.sh` aligns bHLH or MYB domain sequences.
* `RxML_*.sh` generates phylogenic trees for bHLH or MYB domain proteins.
* `MYB_bHLH_trees.Rmd` generates data visualization for phylogenic trees. 

## Overexpression assays and RNA-seq analysis 

* `cutadpat.sh` removes adapter sequences.
* `kallisto_batch.sh` quantifies gene expression.
* `TF_OE.Rmd` generates data visualization. 
