#!/bin/bash

primer="RBCL"
projname="DIATOMS_${primer}"
## Number of bp overlapping between forward and reverse reads required for merging in DADA2. Default is 12, but I have found that this can be relaxed to 10 for 18s amplicons without a significant loss of quality. This allows more reads to be retained after denoising. See
overlap=10
## 16 used for threads to not hit the maximum number (18); this was also run at a time (out of class) where not many people were using the threads
threads=16
## trunc
trunclenf=85
trunclenr=85
    
## trim
trimleftf=0
trimleftr=0

echo "begin denoise..."

qiime dada2 denoise-paired \
    --i-demultiplexed-seqs data/results/${projname}_demux_cutadapt_t.qza  \
    --p-trunc-len-f ${trunclenf} \
    --p-trunc-len-r ${trunclenr} \
    --p-trim-left-f ${trimleftf} \
    --p-trim-left-r ${trimleftr} \
    --p-n-threads ${threads} \
    --p-pooling-method 'pseudo' \
    --p-min-overlap ${overlap} \
    --p-allow-one-off \
    --o-denoising-stats data/results/${projname}_dns_t.qza \
    --o-base-transition-stats data/results/${projname}_base-transition_t.qza \
    --o-table data/results/${projname}_table_test_t.qza \
    --o-representative-sequences data/results/${projname}_rep-seqs_t.qza