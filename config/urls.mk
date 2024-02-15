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
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.methylation27.tsv.gz \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.methylation450.tsv.gz \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.mutect2_snv.tsv.gz \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/gencode.v22.annotation.gene.probeMap \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/illuminaMethyl27_hg38_GDC \
	https://gdc-hub.s3.us-east-1.amazonaws.com/download/illuminaMethyl450_hg38_GDC \
	https://icgc-xena-hub.s3.us-east-1.amazonaws.com/download/sp%2Fcopy_number_somatic_mutation.all_projects.specimen.gz \
	https://icgc-xena-hub.s3.us-east-1.amazonaws.com/download/sp%2Fexp_seq.all_projects.specimen.USonly.xena.tsv.gz \
	https://icgc-xena-hub.s3.us-east-1.amazonaws.com/download/sp%2Fprotein_expression.all_projects.specimen.xena.tsv.gz \
	https://icgc-xena-hub.s3.us-east-1.amazonaws.com/download/sp%2FSNV.sp.codingMutation-allProjects.gz \
	https://icgc-xena-hub.s3.us-east-1.amazonaws.com/download/sp%2Fspecimen.all_projects.tsv.gz \
	https://pcawg-hub.s3.us-east-1.amazonaws.com/download/20170119_final_consensus_copynumber_sp \
	https://pcawg-hub.s3.us-east-1.amazonaws.com/download/consensus.20170217.purity.ploidy_sp \
	https://pcawg-hub.s3.us-east-1.amazonaws.com/download/October_2016_all_patients_2778.snv_mnv_indel.maf.coding.xena \
	https://pcawg-hub.s3.us-east-1.amazonaws.com/download/pcawg_donor_clinical_August2016_v9_sp \
	https://pcawg-hub.s3.us-east-1.amazonaws.com/download/sp_specimen_type \
	https://pcawg-hub.s3.us-east-1.amazonaws.com/download/sp_wgs_exclusion_white_gray \
	https://pcawg-hub.s3.us-east-1.amazonaws.com/download/tophat_star_fpkm_uq.v2_aliquot_gl.sp.log \
	https://tcga-pancan-atlas-hub.s3.us-east-1.amazonaws.com/download/TCGA-RPPA-pancan-clean.xena.gz \
	https://tcga-pancan-atlas-hub.s3.us-east-1.amazonaws.com/download/Survival_SupplementalTable_S1_20171025_xena_sp \
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
	$(DATA)/gdc-hub/illuminaMethyl27_hg38_GDC \
	$(DATA)/gdc-hub/illuminaMethyl450_hg38_GDC \
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
	$(DATA)/gdc-hub/GDC-PANCAN.methylation27.done \
	$(DATA)/gdc-hub/GDC-PANCAN.methylation450.done \
	$(DATA)/gdc-hub/GDC-PANCAN.mutect2_snv.done \
	$(DATA)/gdc-hub/gencode.v22.annotation.gene.probeMap.done \
	$(DATA)/gdc-hub/illuminaMethyl27_hg38_GDC.done \
	$(DATA)/gdc-hub/illuminaMethyl450_hg38_GDC.done \
	$(DATA)/icgc-xena-hub/sp%2Fcopy_number_somatic_mutation.all_projects.specimen.done \
	$(DATA)/icgc-xena-hub/sp%2Fexp_seq.all_projects.specimen.USonly.xena.done \
	$(DATA)/icgc-xena-hub/sp%2Fprotein_expression.all_projects.specimen.xena.done \
	$(DATA)/icgc-xena-hub/sp%2FSNV.sp.codingMutation-allProjects.done \
	$(DATA)/icgc-xena-hub/sp%2Fspecimen.all_projects.done \
	$(DATA)/pcawg-hub/20170119_final_consensus_copynumber_sp.done \
	$(DATA)/pcawg-hub/consensus.20170217.purity.ploidy_sp.done \
	$(DATA)/pcawg-hub/October_2016_all_patients_2778.snv_mnv_indel.maf.coding.xena.done \
	$(DATA)/pcawg-hub/pcawg_donor_clinical_August2016_v9_sp.done \
	$(DATA)/pcawg-hub/sp_specimen_type.done \
	$(DATA)/pcawg-hub/sp_wgs_exclusion_white_gray.done \
	$(DATA)/pcawg-hub/tophat_star_fpkm_uq.v2_aliquot_gl.sp.log.done \
	$(DATA)/tcga-pancan-atlas-hub/RPPA-pancan-clean.xena.done \
	$(DATA)/tcga-pancan-atlas-hub/Survival_SupplementalTable_S1_20171025_xena_sp.done \
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
