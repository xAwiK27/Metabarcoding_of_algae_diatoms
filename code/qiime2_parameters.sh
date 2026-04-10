#!/bin/bash

## qiime2 parameters for each metabarcode


### 18s
	
    overlap=10
    fw='GTACACACCGCCCGTC'
    rv='TGATCCTTCTGCAGGTTCACCTAC'

    cutadapt_config="--p-front-f $fw --p-front-r $rv"

    echo $cutadapt_config

    ## denoise
    polyg_len=85

    ## taxonomy
    maxaccepts=10
    query_cov=0.8 
    perc_identity=0.90 
    weak_id=0.80
    
    ## trunc
    trunclenf=85 
    trunclenr=85

    ## trim
    trimleftf=0
    trimleftr=0

    reftax=${reftax:-/home/users/jtm1171/refdbs/18s/SILVA/silva-138-99-tax.qza}
    refreads=${refreads:-/home/users/jtm1171/refdbs/18s/SILVA/silva-138-99-seqs-pid_0.65-extracted.qza}
    sklearn=${sklearn:-/home/users/jtm1171/refdbs/18s/SILVA/silva-138-99-seqs-pid_0.65-classifier.qza}
 
    min=50
    max=175