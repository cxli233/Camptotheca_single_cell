#!/bin/bash
#SBATCH --job-name=caac_v4_gex_cutadapt		# Job name
#SBATCH --partition=batch		# Partition name (batch, highmem_p, or gpu_p)
#SBATCH --ntasks=1			# Run job in single task, by default using 1 CPU core on a single node
#SBATCH --cpus-per-task=15	 	# CPU core count per task, by default 1 CPU core per task
#SBATCH --mem=128G			# Memory per node (30GB); by default using M as unit
#SBATCH --time=48:00:00              	# Time limit hrs:min:sec or days-hours:minutes:seconds
#SBATCH --output=%x_%j.out		# Standard output log, e.g., testBowtie2_12345.out
#SBATCH --error=%x_%j.err		# Standard error log, e.g., testBowtie2_12345.err
#SBATCH --mail-user=cl56619@uga.edu    # Where to send mail
#SBATCH --mail-type=BEGIN,END,FAIL          	# Mail events (BEGIN, END, FAIL, ALL)

################################################################################
#Project: Single Cell - Clean Reads by Quality Trimming, Removing Adapters, and PolyA Tails
#       Script function: Run Cutadapt on Reads
#       Input: raw_reads.fastq
#       Output: trimmed_reads.fastq
################################################################################

ml cutadapt/3.5-GCCcore-11.2.0

cd /scratch/cl56619/caa_multiome_v4/Data/UCD.101023.aviti0171B
cutadapt CAA_BI_R2.fastq.gz \
--cores=15 -q 30 -m 30 --trim-n -n 2 \
-g AAGCAGTGGTATCAACGCAGAGTACATGGG \
-a "A{20}" \
-o ../GEX_fq/CAA_BI_R2.trim.fastq.gz

cd /scratch/cl56619/caa_multiome_v4/Data/UCD.101023.aviti0171B
cutadapt CAA_BG_R2.fastq.gz \
--cores=15 -q 30 -m 30 --trim-n -n 2 \
-g AAGCAGTGGTATCAACGCAGAGTACATGGG \
-a "A{20}" \
-o ../GEX_fq/CAA_BG_R2.trim.fastq.gz


#Parameters
#file type fastq (autodetects)
#-q: trim bases with a quality score less than 30 from the beginning of the read (3' end)
#-m: minimum length of 100nt for each read
#--trim-n: trim all N bases (bases with no call) (done after adapter trimming)
#-n 2: remove up to two adapters
#-g: remove 5' TSO (flagged as Clontech SMARTer) adapter from read 2 AAGCAGTGGTATCAACGCAGAGTACATGGG
#NOTE: I am trimming this way as I am trimming read 2! for 10X data
#https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/algorithms/overview
#-a: "A{100}" trims polyA tails from reads, used as directed by cutadapt manual for PolyA trimming. 3' end
#-o: output file
#-p: second output file for paired end cleaning

#sbatch --array 1-5 --export=INFILE=/scratch/jcw61311/single_cell/catharanthus/cro_10x_filelist.txt /home/jcw61311/single_cell/scripts/catharanthus_ms/cro_10x_cutadapt.sh
