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
#   make DIR="/path/to/results" MEMORY_LIMIT=8GB NCORES=4 DOWNLOADER=aria2
#
# See cfg.mk for further details on configurables.

#
# Configuration
#
include config/cfg.mk

MAKEFLAGS += --warn-undefined-variables
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all

data_dir := $(DIR)/data
temp_dir := $(DIR)/temp

tbl_names := $(shell awk -F, 'NR>1 {print $$1}' $(CURDIR)/config/data.csv | sort | uniq)
urls := $(shell awk -F, 'NR>1 {print $$2}' $(CURDIR)/config/data.csv | sort | uniq)

.PHONY: all clean

all: directories fetch unzip ingest

directories:
	@mkdir -p $(data_dir) $(temp_dir)

#
# Fetch data from remotes
#

raw_data := $(addprefix $(data_dir)/,$(notdir $(urls)))

.PHONY: fetch unzip
.INTERMEDIATE: $(raw_data)
fetch: $(raw_data)

unzip: $(filter %.zip,$(raw_data))
	@$(foreach zip,$^,unzip -qq $(zip) -d $(data_dir);)

$(data_dir)/%:
	@echo Fetching data from $(filter %$*, $(urls)) ...
	@$(ARIA2) --check-certificate=false -s4 -x16 -k1M -d $(data_dir) -o $(notdir $@) $(filter %$*, $(urls))

#
# Ingest data to database
#

db_targets := $(addsuffix .done, $(addprefix $(temp_dir)/,$(tbl_names)))

.PHONY: create_index ingest
.INTERMEDIATE: $(db_targets)
ingest: create_index $(db_targets)

create_index:
	@echo Create data indices ...
	@$(DUCKDB) $(DB) -bail -c ".read scripts/create_index.sql"

# CPTAC data sets with heterogeneous schema across cancers
het_schema_aliases := cptac_cnv cptac_exp_coding cptac_exp_isoform cptac_gistic cptac_prot

$(temp_dir)/%.done:
	@echo Ingesting $* ...
	@$(DUCKDB) $(DB) -bail -c ".read scripts/$*.sql" && \
	{ \
		if echo "$(het_schema_aliases)" | grep -wq "$*"; then \
			for cancer in BRCA CCRCC COAD GBM HNSCC LSCC LUAD OV PDAC UCEC; do \
				export CANCER="$$cancer"; \
				$(DUCKDB) $(DB) -bail -c ".read scripts/$*-hs.sql"; \
			done; \
		fi; \
	} && \
	touch $@

clean:
	@rm -rf $(data_dir) $(temp_dir)