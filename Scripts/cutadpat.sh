#!/bin/bash
#SBATCH --job-name=cutadapt		# Job name
#SBATCH --partition=batch		# Partition name (batch, highmem_p, or gpu_p)
#SBATCH --ntasks=1			# Run job in single task, by default using 1 CPU core on a single node
#SBATCH --cpus-per-task=20	 	# CPU core count per task, by default 1 CPU core per task
#SBATCH --mem=100G			# Memory per node (30GB); by default using M as unit
#SBATCH --time=1-6:00:00              	# Time limit hrs:min:sec or days-hours:minutes:seconds
#SBATCH --output=%x_%j.out		# Standard output log, e.g., testBowtie2_12345.out
#SBATCH --error=%x_%j.err		# Standard error log, e.g., testBowtie2_12345.err
#SBATCH --mail-user=cl56619@uga.edu    # Where to send mail
#SBATCH --mail-type=ALL         	# Mail events (BEGIN, END, FAIL, ALL)

cd /scratch/cl56619/petal_TF_RNA_seq2/Data/TAM.051224.22TMGWLT3
ml cutadapt/4.5-GCCcore-11.3.0

for R1 in *_R1_001.fastq.gz
do
  echo "$R1 and ${R1/R1/R2}"
cutadapt --cores=20 -q 30 -m 30 --trim-n -n 2 \
-a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
-A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
-o ../fastq_trim/${R1/.fastq.gz/.trim.fastq.gz} \
-p ../fastq_trim/${R1/_R1_001.fastq.gz/_R2_001.trim.fastq.gz} \
$R1 \
${R1/R1/R2}

done

#Parameters
#file type fastq (autodetects)
#-q: trim bases with a quality score less than 30 from the beginning of the read (3' end)
#-m: minimum length of 100nt for each read
#--trim-n: trim all N bases (bases with no call) (done after adapter trimming)
#-n 2: remove up to two adapters
#-a: remove 3' adapter sequence from read 1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCA (Illumina TruSeq Adapter, Read 1)
#-A: remove 3' adapter sequence from read 2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT (Illumina TruSeq Adapter, Read 2)
#-o: output file
#-p: second output file for paired end cleaning

#sbatch --array 1-2 --export=INFILE=filelist.txt example_cutadapt.sh
