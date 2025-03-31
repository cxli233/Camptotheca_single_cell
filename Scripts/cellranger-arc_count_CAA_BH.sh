#!/bin/bash
#SBATCH --job-name=CellRanger_ARC_count_CAA_BH_BI
#SBATCH --partition=highmem_30d_p		# Partition name (batch, heighten_p, or gpu_p), _required_
#SBATCH --ntasks=1 		# Run job in single task or in paralelle, _required_
#SBATCH --cpus-per-task=16		# CPU cores per task
#SBATCH --mem=200G			# How much memory per node, _required_
#SBATCH --time=30-00:00:00		# Time Limit hrs:min:sec or day-hrs:min:sec 2-12:00:00 is 2.5 d, _required_
#SBATCH --export=NONE		# Don't export submit node variables to compute node
#SBATCH --output=%x_%j.out	# Standard output log
#SBATCH --error=%x_%j.err		# Standard error log
#SBATCH --mail-user=cl56619@uga.edu # Send an email when job is done or dead
#SBATCH --mail-type=ALL	# Mail events (BEGIN, END, FAIL, ALL)

cd $SLURM_SUBMIT_DIR		# Change dir to job submission dir (optional)
cd /scratch/cl56619/caa_multiome
ml CellRanger-ARC/2.0.2

cellranger-arc count --id=CAA_BH_BI \
 --reference=/scratch/cl56619/caa_multiome_v4/Data/caac_v4_cellranger_arc_ref/ \
 --libraries=/scratch/cl56619/caa_multiome_v4/Data/CAA_multi_BH_BI.csv
