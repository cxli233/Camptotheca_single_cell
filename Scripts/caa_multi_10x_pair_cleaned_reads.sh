#!/bin/bash
#SBATCH --job-name=cro_10x_pair_cleaned_reads		# Job name
#SBATCH --partition=batch		# Partition name (batch, highmem_p, or gpu_p)
#SBATCH --ntasks=1			# Run job in single task, by default using 1 CPU core on a single node
#SBATCH --cpus-per-task=5	 	# CPU core count per task, by default 1 CPU core per task
#SBATCH --mem=128G			# Memory per node (30GB); by default using M as unit
#SBATCH --time=24:00:00              	# Time limit hrs:min:sec or days-hours:minutes:seconds
#SBATCH --output=%x_%j.out		# Standard output log, e.g., testBowtie2_12345.out
#SBATCH --error=%x_%j.err		# Standard error log, e.g., testBowtie2_12345.err
#SBATCH --mail-user=cl56619@uga.edu    # Where to send mail
#SBATCH --mail-type=BEGIN,END,FAIL          	# Mail events (BEGIN, END, FAIL, ALL)

################################################################################
#Project: Single Cell - Pair the Cleaned R2 and uncleaned R1 reads back together, so they match
#       Script function: Pair reads
#       Input: raw_R1.fastq + cleaned_R2.fastq
#       Output: r1_paired.fastq + r2_paired.fastq
################################################################################

ml purge
ml SeqKit/0.16.1

cd /scratch/cl56619/caa_multiome_v4/Data/GEX_fq

seqkit pair -1 ../UCD.101023.aviti0171B/CAA_BI_R1.fastq.gz -2 CAA_BI_R2.trim.fastq.gz \
-O /scratch/cl56619/caa_multiome/Data/GEX_fq_repair


seqkit pair -1 ../UCD.101023.aviti0171B/CAA_BG_R1.fastq.gz -2 CAA_BG_R2.trim.fastq.gz \
-O /scratch/cl56619/caa_multiome/Data/GEX_fq_repair



#Parameters
#Usage:
#  seqkit pair [flags]
#
#Flags:
#  -f, --force            overwrite output directory
#  -h, --help             help for pair
#  -O, --out-dir string   output directory
#  -1, --read1 string     (gzipped) read1 file
#  -2, --read2 string     (gzipped) read2 file
#  -u, --save-unpaired    save unpaired reads if there are
