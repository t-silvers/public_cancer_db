# Makefile for Creating a Peristent DuckDB Database for Public Cancer Data
#
# Facilitates downloading public cancer data from S3 buckets, extracting the data, 
# performing light ETL, and creating a DuckDB database. Supports the use of wget or 
# aria2 for downloading data. To use aria2, specify DOWNLOADER when invoking.
#
# Primary targets:
# - all: Executes the main pipeline, including download, extraction, and database preparation.
# - clean: Removes all generated files.
#
# Usage example:
#   make DATA="/path/to/results" MEMORY_LIMIT=8GB NCORES=4 DOWNLOADER=aria2
#
# See config.mk for further details on configurables.

#
# Configuration
#
include config/cfg.mk
include config/urls.mk

MAKEFLAGS += --warn-undefined-variables
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:

# 
# Fetch data
#

define url_to_path
$(shell echo $(1) | sed -E 's|https://([^.]*)\.s3\..*\.amazonaws\.com/(download/)?(.*/)?([^/]*)$$|$(DATA)/\1/\4|')
endef

RAW_DATA := $(foreach url,$(URLS),$(call url_to_path,$(url)))
UNZIPPED := $(basename $(filter %.zip,$(RAW_DATA)))

.PHONY: all clean

all: fetch_data make_databases

.PHONY: fetch_data

fetch_data: $(RAW_DATA) $(UNZIPPED)

$(RAW_DATA):
	$(eval URL=$(filter %$(notdir $@), $(URLS)))
	@mkdir -p $(dir $@)
	$(call get_download_cmd,$(DOWNLOADER))

%: %.zip
	$(UNZIP) -qq $< -d $(dir $<) && touch $@

# 
# Create database(s) with real data
#

.PHONY: make_databases

make_databases: $(DATA)/create_indices.done database_targets $(CPTAC_HET_SCHEMA_TARGETS)

database_targets: \
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
	$(DATA)/pcawg-hub/tophat_star_fpkm_uq.v2_aliquot_gl.sp.log.done
	$(DATA)/tcga-pancan-atlas-hub/TCGA-RPPA-pancan-clean.xena.done \
	$(DATA)/tcga-pancan-atlas-hub/Survival_SupplementalTable_S1_20171025_xena_sp.done \
	$(DATA)/toil-xena-hub/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.done \
	$(DATA)/toil-xena-hub/mc3.v0.2.8.PUBLIC.toil.xena.done \
	$(DATA)/toil-xena-hub/probeMap%2Fgencode.v23.annotation.transcript.probemap.done \
	$(DATA)/toil-xena-hub/probeMap%2Fhugo_gencode_good_hg38_v23comp_probemap.done \
	$(DATA)/toil-xena-hub/TCGA_GTEX_category.done \
	$(DATA)/toil-xena-hub/TcgaTargetGtex_RSEM_Hugo_norm_count.done \
	$(DATA)/toil-xena-hub/TcgaTargetGtex_RSEM_isoform_fpkm.done \
	$(DATA)/toil-xena-hub/TcgaTargetGtex_rsem_isoform_tpm.done

$(DATA)/create_indices.done: $(INDEX_DATA) $(UNZIPPED)
	$(SHELL) scripts/create_indices.sh $(DATA) $(DUCKDB) $(DB) $(abspath scripts/create_indices.sql) \
	&& touch $@

# GDC

.PHONY: gdc

gdc: $(DATA)/create_indices.done gdc_targets

gdc_targets: \
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
	$(DATA)/gdc-hub/illuminaMethyl450_hg38_GDC.done

$(DATA)/gdc-hub/%.done: $(DATA)/gdc-hub/%
	export DATAPATH="$<"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/$*.sql" && \
	rm $< && \
	touch $@

$(DATA)/gdc-hub/%.done: $(DATA)/gdc-hub/%.tsv.gz
	export DATAPATH="$<"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/$*.sql" && \
	rm $< && \
	touch $@

# ICGC

$(DATA)/icgc-xena-hub/%.done: $(DATA)/icgc-xena-hub/%.gz
	export DATAPATH="$<"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/ICGC-$*.sql" && \
	rm $< && \
	touch $@

$(DATA)/icgc-xena-hub/%.done: $(DATA)/icgc-xena-hub/%.tsv.gz
	export DATAPATH="$<"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/ICGC-$*.sql" && \
	rm $< && \
	touch $@

# PCAWG

$(DATA)/pcawg-hub/%.done: $(DATA)/pcawg-hub/%
	export DATAPATH="$<"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/PCAWG-$*.sql" && \
	rm $< && \
	touch $@

# TCGA

.PHONY: tcga

tcga: $(DATA)/create_indices.done tcga_targets

tcga_targets: \
	$(DATA)/tcga-pancan-atlas-hub/TCGA-RPPA-pancan-clean.xena.done \
	$(DATA)/tcga-pancan-atlas-hub/Survival_SupplementalTable_S1_20171025_xena_sp.done

$(DATA)/tcga-pancan-atlas-hub/%.done: $(DATA)/tcga-pancan-atlas-hub/%
	export DATAPATH="$<"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/TCGA-$*.sql" && \
	rm $< && \
	touch $@

$(DATA)/tcga-pancan-atlas-hub/%.done: $(DATA)/tcga-pancan-atlas-hub/%.gz
	export DATAPATH="$<"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/TCGA-$*.sql" && \
	rm $< && \
	touch $@

# Toil

.PHONY: toil

toil: $(DATA)/create_indices.done toil_targets

toil_targets: \
	$(DATA)/toil-xena-hub/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.done \
	$(DATA)/toil-xena-hub/mc3.v0.2.8.PUBLIC.toil.xena.done \
	$(DATA)/toil-xena-hub/probeMap%2Fgencode.v23.annotation.transcript.probemap.done \
	$(DATA)/toil-xena-hub/probeMap%2Fhugo_gencode_good_hg38_v23comp_probemap.done \
	$(DATA)/toil-xena-hub/TCGA_GTEX_category.done \
	$(DATA)/toil-xena-hub/TcgaTargetGtex_RSEM_Hugo_norm_count.done \
	$(DATA)/toil-xena-hub/TcgaTargetGtex_RSEM_isoform_fpkm.done \
	$(DATA)/toil-xena-hub/TcgaTargetGtex_rsem_isoform_tpm.done

$(DATA)/toil-xena-hub/%.done: $(DATA)/toil-xena-hub/%
	export DATAPATH="$<"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/Toil-$*.sql" && \
	rm $< && \
	touch $@

$(DATA)/toil-xena-hub/%.done: $(DATA)/toil-xena-hub/%.gz
	export DATAPATH="$<"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/Toil-$*.sql" && \
	rm $< && \
	touch $@

$(DATA)/toil-xena-hub/%.done: $(DATA)/toil-xena-hub/%.txt
	export DATAPATH="$<"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/Toil-$*.sql" && \
	rm $< && \
	touch $@

# GTEx age

# From https://gtexportal.org/home/downloads/adult-gtex/metadata

$(DATA)/toil-xena-hub/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.done:
	export DATAPATH="https://storage.googleapis.com/adult-gtex/annotations/v8/metadata-files/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/Toil-GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.sql" && \
	touch $@

# CPTAC

.PHONY: cptac

cptac: $(filter %cptac-pancancer-data%, $(DATABASE_TARGETS)) $(CPTAC_HET_SCHEMA_TARGETS)

$(DATA)/cptac-pancancer-data/%.done: $(UNZIPPED)
	export DATADIR="$(DATA)"; \
	export DATAPATH="$(DATA)/cptac-pancancer-data/*/*_$**"; \
	export REGEX="/(\w+)_$*"; \
	$(DUCKDB) $(DB) -bail -c ".read scripts/CPTAC-$*.sql" && \
	touch $@

# CPTAC data with heterogenous schema
$(DATA)/cptac-pancancer-data/%.hetschema: $(DATA)/cptac-pancancer-data/%.done
	@for cancer in BRCA CCRCC COAD GBM HNSCC LSCC LUAD OV PDAC UCEC; do \
		export DATADIR="$(DATA)"; \
		export CANCER="$$cancer"; \
		export DATASET="$*"; \
		$(DUCKDB) $(DB) -bail -c ".read scripts/CPTAC-$*-hetschema.sql"; \
	done && \
	touch $@

clean:
	@echo "Cleaning up"
	@rm -rf $(RAW_DATA)
	@rm -rf $(UNZIPPED)
	@rm -f $(DATABASE_TARGETS)
	@rm -f $(CPTAC_HET_SCHEMA_TARGETS)