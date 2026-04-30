#!/bin/bash

# Setting project variables
primer="RBCL"
projname="DIATOMS_${primer}"

# Entering QIIME conda environment
conda activate qiime2-amplicon-2026.1  

## Setting primers, copied from qiime2_parameters.sh
    fw1="^AGGTGAAGTAAAAGGTTCWTACTTAAA"
    fw2="^AGGTGAAGTTAAAGGTTCWTAYTTAAA"
    fw3="^AGGTGAAACTAAAGGTTCWTACTTAAA"
 
    rv1="^CCTTCTAATTTACCWACWACTG"
    rv2="^CCTTCTAATTTACCWACAACAG"

# Setting configuation for qiime's cutadapt tool
    cutadapt_config="--p-front-f $fw1 --p-front-f $fw2 --p-front-f $fw3 --p-front-r $rv1 --p-front-r $rv2"


### See qiime2_parameters.sh for cutadapt parameters and 01_trim.sh for polyG filter parameters.


### import tools
qiime tools import \
    --type "SampleData[PairedEndSequencesWithQuality]"  \
    --input-format CasavaOneEightSingleLanePerSampleDirFmt \
    --input-path data/poly-G-trimmed \
    --output-path data/results/${projname}_demux.qza 

# Run actual cutadapt script to trim paired-end reads
qiime cutadapt trim-paired \
    --i-demultiplexed-sequences data/results/${projname}_demux.qza \
    --p-error-rate 0.12 \
    --o-trimmed-sequences data/results/${projname}_demux_cutadapt.qza \
    --p-cores 16 \
    $cutadapt_config \
    --p-discard-untrimmed \
    --p-match-adapter-wildcards \
    --verbose 
    
# Summarize the data in a bioinformatics analyzable form (including a plot)
qiime demux summarize \
    --i-data data/results/${projname}_demux_cutadapt.qza \
    --o-visualization data/results/${projname}_demux_cutadapt.qzv


