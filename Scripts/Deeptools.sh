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

# deepTools bam to bigwig
ml deepTools/3.5.2-foss-2022a

bamCoverage --bam /scratch/cl56619/caa_multiome_v4/CAA_BF_BG/outs/atac_possorted_bam.bam \
--outFileName CAA_BF.bigwig \
--outFileFormat bigwig \
--ignoreDuplicates \
--normalizeUsing CPM

bamCoverage --bam /scratch/cl56619/caa_multiome_v4/CAA_BH_BI/outs/atac_possorted_bam.bam \
--outFileName CAA_BH.bigwig \
--outFileFormat bigwig \
--ignoreDuplicates \
--normalizeUsing CPM

# Make matrix at genes
# computeMatrix scale-regions -S CAA_BF.bigwig \
#                            -R /scratch/cl56619/caa_multiome/Data/gene.bed \
#                            --beforeRegionStartLength 3000 \
#                            --regionBodyLength 5000 \
#                            --afterRegionStartLength 3000 \
#                            -out CAA_BF.gene.tab.gz \
#                            --skipZeros
##

#computeMatrix scale-regions -S CAA_BH.bigwig \
#                            -R /scratch/cl56619/caa_multiome/Data/gene.bed \
#                            --beforeRegionStartLength 3000 \
#                            --regionBodyLength 5000 \
#                            --afterRegionStartLength 3000 \
#                            -out CAA_BH.gene.tab.gz \
#                            --skipZeros

# Matrix at peaks
#computeMatrix reference-point -S CAA_BF.bigwig \
#                            -R ../MACS2_out/MACS2_broad_peaks.bed \
#                            --referencePoint center \
#                            -b 2000 \
#                            -a 2000 \
#                            -out CAA_BF.tab.gz \
#                            --skipZeros

##
#computeMatrix reference-point -S CAA_BH.bigwig \
#                            -R ../MACS2_out/MACS2_broad_peaks.bed \
#                            --referencePoint center \
#                            -b 2000 \
#                            -a 2000 \
#                            -out CAA_BH.tab.gz \
#                            --skipZeros
