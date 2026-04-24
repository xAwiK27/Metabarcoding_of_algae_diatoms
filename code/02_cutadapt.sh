#!/bin/bash
primer="RBCL"
projname="DIATOMS_${primer}"
## example: projname="Cyanobac_16s_V4-V5"

## copied from qiime2_parameters.sh
    fw1="^AGGTGAAGTAAAAGGTTCWTACTTAAA"
    fw2="^AGGTGAAGTTAAAGGTTCWTAYTTAAA"
    fw3="^AGGTGAAACTAAAGGTTCWTACTTAAA"
 
    rv1="^CCTTCTAATTTACCWACWACTG"
    rv2="^CCTTCTAATTTACCWACAACAG"

    cutadapt_config="--p-front-f $fw1 --p-front-f $fw2 --p-front-f $fw3 --p-front-r $rv1 --p-front-r $rv2"


### See qiime2_parameters.sh for cutadapt parameters and 01_trim.sh for polyG filter parameters.

## All filenames have _t in them as this was the test to see if this script had issues. There was an issue, so all _t files are being kept.


### import 
qiime tools import \
    --type "SampleData[PairedEndSequencesWithQuality]"  \
    --input-format CasavaOneEightSingleLanePerSampleDirFmt \
    --input-path data/poly-G-trimmed \
    --output-path data/results/${projname}_demux_t.qza 

## The original given cutadapt script was "too strict" in it's screening, causing the denoising script to fail. The line commented out below the script was removed as that was the specific line causing failure. No reads met the specific criteria for the denoise script to actually function (giving a no reads entered error), and this line was removed to fix it.


qiime cutadapt trim-paired \
    --i-demultiplexed-sequences data/results/${projname}_demux_t.qza \
    --p-error-rate 0.12 \
    --o-trimmed-sequences data/results/${projname}_demux_cutadapt_t.qza \
    --p-cores 4 \
    $cutadapt_config \
    --p-match-adapter-wildcards \
    --verbose 
    ##--p-discard-untrimmed \ --> This is the removed line, it had to be placed here so the script would work with the formatting/syntax

qiime demux summarize \
    --i-data data/results/${projname}_demux_cutadapt_t.qza \
    --o-visualization data/results/${projname}_demux_cutadapt_t.qzv


