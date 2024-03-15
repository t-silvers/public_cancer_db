# Makefile for Creating a Peristent DuckDB Database for Public Cancer Data
#
# Facilitates downloading public cancer data from S3 buckets, extracting the data, 
# performing light ETL, and creating a DuckDB database. Supports the use of wget or 
# aria2 for downloading data. To use aria2, specify DOWNLOADER when invoking.
#
# Primary targets:
# - all: Executes the main pipeline, including download, extraction, and database preparation.
# - fetch: Download data files.
# - ingest: Add data to database.
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

.PHONY: all clean

all: check_params directories fetch unzip ingest

.PHONY: check_params directories

check_params:
	@echo "MEMORY_LIMIT = $(MEMORY_LIMIT)"
	@echo "NCORES = $(NCORES)"
	@echo "DIR = $(DIR)"
	@echo "DB = $(DB)"
	@echo "ARIA2 = $(ARIA2)"
	@echo "DUCKDB = $(DUCKDB)"
	@echo "DOWNLOADER = $(DOWNLOADER)"
	@echo "data_dir = $(data_dir)"
	@echo "temp_dir = $(temp_dir)"
	@echo "data_config = $(data_config)"

directories:
	@mkdir -p $(data_dir) $(temp_dir)

#
# Fetch data from remotes
#

raw_data := $(addprefix $(data_dir)/,$(notdir $(urls)))

.PHONY: fetch unzip

fetch: directories $(raw_data) unzip

unzip: $(filter %.zip,$(raw_data))
	@echo Unzipping $^ ...
	@$(foreach zip,$^,unzip -qq $(zip) -d $(data_dir);)

$(data_dir)/%:
	@echo Fetching data from $(filter %$*, $(urls)) ...
	@$(ARIA2) --quiet --check-certificate=false -s4 -x16 -k1M -d $(data_dir) -o $(notdir $@) $(filter %$*, $(urls))

#
# Ingest data to database
#

db_targets := $(addsuffix .done, $(addprefix $(temp_dir)/,$(tbl_names)))

.PHONY: create_index ingest

# TODO: Allow multiple makes to populate database when errors encountered.
# 		Could also use `CREATE IF NOT EXISTS` in SQL, but will fail for CPTAC,
# 		where table creation and insertion is separate.

# .INTERMEDIATE: $(db_targets)

.IGNORE: $(db_targets)

ingest: directories create_index $(db_targets)

# TODO: Once support added for the DuckDB config to change directories,
# 		will need to change paths for model scripts.

create_index:
	@echo Create data indices ...
	@$(DUCKDB) $(DB) -init $(db_config) -c ".read models/create_index.sql"

# CPTAC data sets with heterogeneous schema across cancers
het_schema_aliases := cptac_cnv cptac_exp_coding cptac_exp_isoform cptac_gistic cptac_prot

$(temp_dir)/%.done:
	@echo Ingesting $* ...
	@$(DUCKDB) $(DB) -bail -c ".read models/$*.sql" && \
	{ \
		if echo "$(het_schema_aliases)" | grep -wq "$*"; then \
			for cancer in BRCA CCRCC COAD GBM HNSCC LSCC LUAD OV PDAC UCEC; do \
				export CANCER="$$cancer"; \
				$(DUCKDB) $(DB) -init $(db_config) -c ".read models/$*-hs.sql"; \
			done; \
		fi; \
	} && \
	touch $@

clean:
	@rm -rf $(data_dir) $(temp_dir)