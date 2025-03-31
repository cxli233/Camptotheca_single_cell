#!/bin/bash
#SBATCH --job-name=BHLH_alignment
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=48GB
#SBATCH --time=48:00:00
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --mail-user=cl56619@uga.edu
#SBATCH --mail-type=ALL

cd /scratch/cl56619/caa_multiome_v4/Results/Phylogeny

ml MAFFT/7.505-GCC-11.3.0-with-extensions
mafft --anysymbol --maxiterate 1000 --localpair AT_CRO_CAAC_v4_bhlh_domains.fa > BHLH_domains.aln
