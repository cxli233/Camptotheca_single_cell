#!/bin/bash
#SBATCH --job-name=MEME_caa
#SBATCH --partition=batch		# Partition name (batch, heighten_p, or gpu_p), _required_
#SBATCH --ntasks=1 		# Run job in single task or in paralelle, _required_
#SBATCH --cpus-per-task=6		# CPU cores per task
#SBATCH --mem=128G			# How much memory per node, _required_
#SBATCH --time=100:00:00		# Time Limit hrs:min:sec or day-hrs:min:sec 2-12:00:00 is 2.5 d, _required_
#SBATCH --export=NONE		# Don't export submit node variables to compute node
#SBATCH --output=%x_%j.out	# Standard output log
#SBATCH --error=%x_%j.err		# Standard error log
#SBATCH --mail-user=cl56619@uga.edu # Send an email when job is done or dead
#SBATCH --mail-type=ALL	# Mail events (BEGIN, END, FAIL, ALL)

cd $SLURM_SUBMIT_DIR		# Change dir to job submission dir (optional)
ml MEME/5.5.0-gompi-2021b

cd /scratch/cl56619/caa_multiome_v4/Results/MEME

for fasta in *.fasta
do echo $fasta
meme $fasta \
-o ${fasta/.fa/.meme_12} \
-dna \
-revcomp \
-mod anr \
-nmotifs 20 \
-minw 5 \
-maxw 12 \
-evt 0.001
done
