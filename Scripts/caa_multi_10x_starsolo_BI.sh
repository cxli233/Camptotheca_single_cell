#!/bin/bash
#SBATCH --job-name=caa_multi_gex_starsolo-BI	# Job name
#SBATCH --partition=highmem_p		# Partition name (batch, highmem_p, or gpu_p)
#SBATCH --ntasks=1			# Run job in single task, by default using 1 CPU core on a single node
#SBATCH --cpus-per-task=24	 	# CPU core count per task, by default 1 CPU core per task
#SBATCH --mem=200G			# Memory per node (30GB); by default using M as unit
#SBATCH --time=128:00:00              	# Time limit hrs:min:sec or days-hours:minutes:seconds
#SBATCH --output=%x_%j.out		# Standard output log, e.g., testBowtie2_12345.out
#SBATCH --error=%x_%j.err		# Standard error log, e.g., testBowtie2_12345.err
#SBATCH --mail-user=cl56619@uga.edu    # Where to send mail
#SBATCH --mail-type=BEGIN,END,FAIL          	# Mail events (BEGIN, END, FAIL, ALL)

################################################################################
#Project: Single Cell - Align RNAseq Reads to Genome
#       Script function: Align RNAseq Reads to Genome
#       Input: trimmed_reads.fastq
#       Output: alignments.sam --> alignmnets.sorted.bam
################################################################################

ml STAR/2.7.10b-GCC-11.3.0
cd $SLURM_SUBMIT_DIR		# Change dir to job submission dir (optional)

cd /scratch/cl56619/caa_multiome_v4/Data/GEX_fq_repair/CAA_BI

#STARsolo alignment
STAR --genomeDir /scratch/cl56619/caa_multiome_v4/Data/caac_v4_star_ref \
--readFilesIn CAA_BI_R2.trim.fastq CAA_BI_R1.fastq \
--runThreadN 24 \
--alignIntronMax 5000 \
--soloBarcodeReadLength 0 \
--soloUMIlen 12 \
--soloCellFilter EmptyDrops_CR \
--soloFeatures GeneFull \
--soloMultiMappers EM \
--soloType CB_UMI_Simple \
--soloCBwhitelist /scratch/cl56619/caa_multiome_v4/Data/737K-arc-v1.txt \
--outSAMtype BAM SortedByCoordinate \
--limitBAMsortRAM 26843545600 \
--soloOutFileNames CAA_BI


#Parameters
#/path/to/STAR --genomeDir /path/to/genome/dir/ --readFilesIn ...  [...other parameters...] --soloType ... --soloCBwhitelist ...
#https://github.com/alexdobin/STAR/blob/master/docs/STARsolo.md
#--readFilesIn option, the 1st file has to be cDNA read, and the 2nd file has to be the barcode (cell+UMI) read, i.e.
#--alignIntronMax 5000: default: 0. maximum intron size, if 0, max intron size will be determined by (2ˆwinBinNbits)*winAnchorDistNbins. This results in a default max of around 500,000
#--soloUMIlen 12: The default barcode lengths (CB=16b, UMI=10b) work for 10X Chromium V2. For V3, specify: --soloUMIlen 12
#--soloCellFilter  EmptyDrops_CR: CellRanger 3.0.0 use advanced filtering based on the EmptyDrop algorithm developed by Lun et al. This algorithm calls extra cells compared to the knee filtering, allowing for cells that have relatively fewer UMIs but are transcriptionally different from the ambient RNA. In STARsolo, this filtering can be activated by:
#--soloFeatures GeneFull: pre-mRNA counts, useful for single-nucleus RNA-seq. This counts all read that overlap gene loci, i.e. included both exonic and intronic reads:
#	10x now recommends using intronic counts going forward, so I've turned this option on
#The multi-gene read recovery options are specified with --soloMultiMappers. Several algorithms are implemented:
#	--soloMultiMappers Uniform: uniformly distributes the multi-gene UMIs to all genes in its gene set. Each gene gets a fractional count of 1/N_genes, where N_genes is the number of genes in the set. This is the simplest possible option, and it offers higher sensitivity for gene detection at the expense of lower precision.
#	--soloMultiMappers EM: uses Maximum Likelihood Estimation (MLE) to distribute multi-gene UMIs among their genes, taking into account other UMIs (both unique- and multi-gene) from the same cell (i.e. with the same CB). Expectation-Maximization (EM) algorithm is used to find the gene expression values that maximize the likelihood function. Recovering multi-gene reads via MLE-EM model was previously used to quantify transposable elements in bulk RNA-seq {TEtranscripts} and in scRNA-seq {Alevin; Kallisto-bustools}.
#--outSAMtype: Output in BAM sorted by coordinate

#sbatch --array 1-5 --export=INFILE=/scratch/jcw61311/single_cell/catharanthus/cro_10x_starsolo_filelist.txt /home/jcw61311/single_cell/scripts/catharanthus_ms/cro_10x_starsolo.sh
