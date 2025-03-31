#!/bin/bash
#SBATCH --job-name=kallisto_ns
#SBATCH --partition=batch		# Partition name (batch, heighten_p, or gpu_p), _required_
#SBATCH --ntasks=1 		# Run job in single task or in paralelle, _required_
#SBATCH --cpus-per-task=12		# CPU cores per task
#SBATCH --mem=64G			# How much memory per node, _required_
#SBATCH --time=100:00:00		# Time Limit hrs:min:sec or day-hrs:min:sec 2-12:00:00 is 2.5 d, _required_
#SBATCH --export=NONE		# Don't export submit node variables to compute node
#SBATCH --output=%x_%j.out	# Standard output log
#SBATCH --error=%x_%j.err		# Standard error log
#SBATCH --mail-user=cl56619@uga.edu # Send an email when job is done or dead
#SBATCH --mail-type=ALL	# Mail events (BEGIN, END, FAIL, ALL)

ml kallisto/0.48.0-gompi-2022a
cd /scratch/cl56619/petal_TF_RNA_seq2/Data/fastq_trim/

for read1 in *R1_001.trim.fastq.gz
do
echo "$read1 and ${read1/R1/R2}"

kallisto quant -i ../kallisto.cro.append1.index \
-o /scratch/cl56619/petal_TF_RNA_seq2/Results/kallisto_out/${read1/_S1_L001_R1_001.trim.fastq.gz/.out} \
--plaintext \
$read1 ${read1/R1/R2}
done
