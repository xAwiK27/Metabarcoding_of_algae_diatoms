#!/bin/bash

primer="RBCL"
projname="DIATOMS_${primer}"
## 5 threads are used here because upon initial running with 16 threads outside of class, the reftax, refreads, and sklearn variable file locations are unreadable (lack of permission)

threads=5
## Classifiy, copied from qiime2_parameters.sh
reftax=${reftax:-/home/users/jtm1171/refdbs/18s/SILVA/silva-138-99-tax.qza}
refreads=${refreads:-/home/users/jtm1171/refdbs/18s/SILVA/silva-138-99-seqs-pid_0.65-extracted.qza}
sklearn=${sklearn:-/home/users/jtm1171/refdbs/18s/SILVA/silva-138-99-seqs-pid_0.65-classifier.qza}

## copied from qiime2_parameters.sh
 maxaccepts=10
 query_cov=0.8 
 perc_identity=0.90 
 weak_id=0.80

qiime feature-classifier classify-hybrid-vsearch-sklearn \
  --i-query data/results/${projname}_rep-seqs_t.qza \
  --i-classifier ${sklearn} \
  --i-reference-reads ${refreads} \
  --i-reference-taxonomy  ${reftax} \
  --p-threads ${threads} \
  --p-query-cov ${query_cov} \
  --p-perc-identity ${perc_identity} \
  --p-maxrejects all \
  --p-maxaccepts ${maxaccepts} \
  --p-maxhits all \
  --p-min-consensus 0.51 \
  --p-confidence 0.7 \
  --o-classification data/results/${projname}_hybrid_taxonomy.qza