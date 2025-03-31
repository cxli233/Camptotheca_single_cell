#!/bin/bash
#SBATCH --job-name=metaplot_matrix
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=48gb
#SBATCH --cpus-per-task=16
#SBATCH --time=24:00:00
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --mail-user=cl56619@uga.edu
#SBATCH --mail-type=ALL

cd /scratch/cl56619/caa_multiome_v4/Results/deeptools_out

ml deepTools/3.5.2-foss-2022a
# Make matrix at genes
computeMatrix scale-regions -S CAA_BF.bigwig \
                            -R /scratch/cl56619/caa_multiome_v4/Results/bedtools/v4.sorted.bed \
                            --beforeRegionStartLength 3000 \
                            --regionBodyLength 5000 \
                            --afterRegionStartLength 3000 \
                            -out CAA_BF.gene.tab.gz \
                            --skipZeros


computeMatrix scale-regions -S CAA_BH.bigwig \
                            -R /scratch/cl56619/caa_multiome_v4/Results/bedtools/v4.sorted.bed \
                            --beforeRegionStartLength 3000 \
                            --regionBodyLength 5000 \
                            --afterRegionStartLength 3000 \
                            -out CAA_BH.gene.tab.gz \
                            --skipZeros

# Matrix at peaks
computeMatrix reference-point -S CAA_BF.bigwig \
                            -R /scratch/cl56619/caa_multiome_v4/Results/bedtools/CAA_leaf_atac.bed \
                            --referencePoint center \
                            -b 2000 \
                            -a 2000 \
                            -out CAA_BF.tab.gz \
                            --skipZeros


computeMatrix reference-point -S CAA_BH.bigwig \
                            -R /scratch/cl56619/caa_multiome_v4/Results/bedtools/CAA_leaf_atac.bed \
                            --referencePoint center \
                            -b 2000 \
                            -a 2000 \
                            -out CAA_BH.tab.gz \
                            --skipZeros
