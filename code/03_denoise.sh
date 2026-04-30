#!/bin/bash

# Setting Project variables
primer="RBCL"
projname="DIATOMS_${primer}"

# Entering QIIME conda environment
conda activate qiime2-amplicon-2026.1  

# Setting computing power variable
threads=16
#Setting DADA2 and denoising parameters, copied from qiime2_parameters.sh
    ## truncation varaibles
    trunclenr=200
    trunclenf=200
    ## trimming variables
    trimleftf=0
    trimleftr=0

    overlap=12

echo "begin denoise..."


# DADA2 denoising paired end reads based on given parameters above
qiime dada2 denoise-paired \
    --i-demultiplexed-seqs data/results/${projname}_demux_cutadapt.qza  \
    --p-trunc-len-f ${trunclenf} \
    --p-trunc-len-r ${trunclenr} \
    --p-trim-left-f ${trimleftf} \
    --p-trim-left-r ${trimleftr} \
    --p-n-threads ${threads} \
    --p-pooling-method 'pseudo' \
    --p-min-overlap ${overlap} \
    --p-allow-one-off \
    --o-denoising-stats data/results/${projname}_dns.qza \
    --o-base-transition-stats data/results/${projname}_base-transition.qza \
    --o-table data/results/${projname}_table.qza \
    --o-representative-sequences data/results/${projname}_rep-seqs.qza