#!/bin/bash
primer="18s"
projname="DIATOMS_${primer}"
## example: projname="Cyanobac_16s_V4-V5"

## copied from qiime2_parameters.sh
fw='GTACACACCGCCCGTC'
rv='TGATCCTTCTGCAGGTTCACCTAC'
cutadapt_config="--p-front-f $fw --p-front-r $rv"

### See qiime2_parameters.sh for cutadapt parameters and 01_trim.sh for polyG filter parameters.

### import 
qiime tools import \
    --type "SampleData[PairedEndSequencesWithQuality]"  \
    --input-format CasavaOneEightSingleLanePerSampleDirFmt \
    --input-path data/poly-G-trimmed \
    --output-path data/results/${projname}_demux 

qiime cutadapt trim-paired \
    --i-demultiplexed-sequences data/results/${projname}_demux.qza \
    --p-error-rate 0.12 \
    --o-trimmed-sequences data/results/${projname}_demux_cutadapt.qza \
    --p-cores 4 \
    $cutadapt_config \
    --p-discard-untrimmed \
    --p-match-adapter-wildcards \
    --verbose 

qiime demux summarize \
    --i-data data/results/${projname}_demux_cutadapt.qza \
    --o-visualization data/results/${projname}_demux_cutadapt.qzv


