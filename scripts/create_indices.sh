#!/bin/bash

# Setup environment variables
export CPTACPHENO="$1/cptac-pancancer-data/*/*_CaseList.txt"
export GDCPHENO="$1/gdc-hub/GDC-PANCAN.basic_phenotype.tsv.gz"
export GDCPROBEMAP="$1/gdc-hub/gencode.v22.annotation.gene.probeMap"
export TOILTRANSCRIPTPROBEMAP="$1/toil-xena-hub/probeMap%2Fgencode.v23.annotation.transcript.probemap"
export TOILPHENO="$1/toil-xena-hub/TCGA_GTEX_category.txt"
export TOILPROBEMAP="$1/toil-xena-hub/probeMap%2Fhugo_gencode_good_hg38_v23comp_probemap"
export TOILSNVS="$1/toil-xena-hub/mc3.v0.2.8.PUBLIC.toil.xena.gz"

# Execute SQL script
$2 $3 -bail -c ".read $4"
