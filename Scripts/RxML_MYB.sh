#!/bin/bash
#SBATCH --job-name=MYB_tree
#SBATCH --partition=batch
#SBATCH --time=100:00:00
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=4
#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=5G
#SBATCH --output=%x_%j.out		# Standard output log, e.g., testBowtie2_12345.out
#SBATCH --error=%x_%j.err		# Standard error log, e.g., testBowtie2_12345.err
#SBATCH --mail-user=cl56619@uga.edu    # Where to send mail
#SBATCH --mail-type=BEGIN,END,FAIL          	# Mail events (BEGIN, END, FAIL, ALL)


ml RAxML/8.2.12-GCC-10.2.0-pthreads-avx2

cd /scratch/cl56619/caa_multiome_v4/Results/Phylogeny

raxmlHPC -s MYB_domains.aln -f a -m PROTGAMMAAUTO -n myb_out -x 666 -N 1000 -p 666 -T 4

# -s: input
# -f: algorith: -f a: rapid Bootstrap analysis and search for bestscoring ML tree in one program run
# -m: substitution model
# -n: output name
# -x: Specify an integer number (random seed) and turn on rapid bootstrapping
# -T: number of threads
# -N: number of alternative runs for bootstrapping
# -p: Specify an integer number (random seed) for parsimony
