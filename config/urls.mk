# GDC URLs (via UCSC Xena, https://xenabrowser.net/datapages)

# PDC URLs (via LinkedOmicsKB, https://kb.linkedomics.org/download)

URLS := \
	https://cptac-pancancer-data.s3.us-west-2.amazonaws.com/data_freeze_v1.2_reorganized/zip_files/BRCA.zip \
	https://cptac-pancancer-data.s3.us-west-2.amazonaws.com/data_freeze_v1.2_reorganized/zip_files/CCRCC.zip \
	https://cptac-pancancer-data.s3.us-west-2.amazonaws.com/data_freeze_v1.2_reorganized/zip_files/COAD.zip \
	https://cptac-pancancer-data.s3.us-west-2.amazonaws.com/data_freeze_v1.2_reorganized/zip_files/GBM.zip \
	https://cptac-pancancer-data.s3.us-west-2.amazonaws.com/data_freeze_v1.2_reorganized/zip_files/HNSCC.zip \
	https://cptac-pancancer-data.s3.us-west-2.amazonaws.com/data_freeze_v1.2_reorganized/zip_files/LSCC.zip \
	https://cptac-pancancer-data.s3.us-west-2.amazonaws.com/data_freeze_v1.2_reorganized/zip_files/LUAD.zip \
	https://cptac-pancancer-data.s3.us-west-2.amazonaws.com/data_freeze_v1.2_reorganized/zip_files/OV.zip \
	https://cptac-pancancer-data.s3.us-west-2.amazonaws.com/data_freeze_v1.2_reorganized/zip_files/PDAC.zip \
	https://cptac-pancancer-data.s3.us-west-2.amazonaws.com/data_freeze_v1.2_reorganized/zip_files/UCEC.zip \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.basic_phenotype.tsv.gz \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.cnv.tsv.gz \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.masked_cnv.tsv.gz \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.gistic.tsv.gz \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.htseq_fpkm-uq.tsv.gz \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.mutect2_snv.tsv.gz \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/gencode.v22.annotation.gene.probeMap \
	https://toil-xena-hub.s3.us-east-1.amazonaws.com/download/mc3.v0.2.8.PUBLIC.toil.xena.gz \
	https://toil-xena-hub.s3.us-east-1.amazonaws.com/download/probeMap%2Fhugo_gencode_good_hg38_v23comp_probemap \
	https://toil-xena-hub.s3.us-east-1.amazonaws.com/download/probeMap%2Fgencode.v23.annotation.transcript.probemap \
	https://toil-xena-hub.s3.us-east-1.amazonaws.com/download/TCGA_GTEX_category.txt \
	https://toil-xena-hub.s3.us-east-1.amazonaws.com/download/TcgaTargetGtex_RSEM_Hugo_norm_count.gz \
	https://toil-xena-hub.s3.us-east-1.amazonaws.com/download/TcgaTargetGtex_RSEM_isoform_fpkm.gz \
	https://toil-xena-hub.s3.us-east-1.amazonaws.com/download/TcgaTargetGtex_rsem_isoform_tpm.gz

INDEX_DATA := \
	$(DATA)/gdc-hub/GDC-PANCAN.basic_phenotype.tsv.gz \
	$(DATA)/gdc-hub/gencode.v22.annotation.gene.probeMap \
	$(DATA)/toil-xena-hub/probeMap%2Fgencode.v23.annotation.transcript.probemap \
	$(DATA)/toil-xena-hub/TCGA_GTEX_category.txt \
	$(DATA)/toil-xena-hub/probeMap%2Fhugo_gencode_good_hg38_v23comp_probemap \
	$(DATA)/toil-xena-hub/mc3.v0.2.8.PUBLIC.toil.xena.gz

DATABASE_TARGETS := \
	$(DATA)/cptac-pancancer-data/CaseList.done \
	$(DATA)/cptac-pancancer-data/meta.done \
	$(DATA)/cptac-pancancer-data/proteomics.done \
	$(DATA)/cptac-pancancer-data/RNAseq_gene_RSEM_coding.done \
	$(DATA)/cptac-pancancer-data/RNAseq_isoform.done \
	$(DATA)/cptac-pancancer-data/somatic_mutation.maf.done \
	$(DATA)/cptac-pancancer-data/survival.done \
	$(DATA)/cptac-pancancer-data/WES_CNV_gene_gistic.done \
	$(DATA)/cptac-pancancer-data/WES_CNV_gene_ratio.done \
	$(DATA)/gdc-hub/GDC-PANCAN.basic_phenotype.done \
	$(DATA)/gdc-hub/GDC-PANCAN.cnv.done \
	$(DATA)/gdc-hub/GDC-PANCAN.gistic.done \
	$(DATA)/gdc-hub/GDC-PANCAN.htseq_fpkm-uq.done \
	$(DATA)/gdc-hub/GDC-PANCAN.masked_cnv.done \
	$(DATA)/gdc-hub/GDC-PANCAN.mutect2_snv.done \
	$(DATA)/gdc-hub/gencode.v22.annotation.gene.probeMap.done \
	$(DATA)/toil-xena-hub/mc3.v0.2.8.PUBLIC.toil.xena.done \
	$(DATA)/toil-xena-hub/probeMap%2Fgencode.v23.annotation.transcript.probemap.done \
	$(DATA)/toil-xena-hub/probeMap%2Fhugo_gencode_good_hg38_v23comp_probemap.done \
	$(DATA)/toil-xena-hub/TCGA_GTEX_category.done \
	$(DATA)/toil-xena-hub/TcgaTargetGtex_RSEM_Hugo_norm_count.done \
	$(DATA)/toil-xena-hub/TcgaTargetGtex_RSEM_isoform_fpkm.done \
	$(DATA)/toil-xena-hub/TcgaTargetGtex_rsem_isoform_tpm.done

# CPTAC data with heterogenous schema
CPTAC_HET_DATASETS := proteomics RNAseq_gene_RSEM_coding RNAseq_isoform WES_CNV_gene_gistic WES_CNV_gene_ratio
CPTAC_HET_SCHEMA_TARGETS := $(foreach dataset,$(CPTAC_HET_DATASETS),$(DATA)/cptac-pancancer-data/$(dataset).hetschema)
