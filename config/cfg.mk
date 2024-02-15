#
# User configuration
#

# Default values for MEMORY_LIMIT and NCORES. Should be overridden.
MEMORY_LIMIT ?= 16GB
NCORES ?= 2

export MEMORY_LIMIT
export NCORES

# Data directory, if not relative to the Makefile.
DATA ?= data

# Database file, if exists already or not in the data directory.
DB ?= $(DATA)/data.duckdb

#
# Configuration
#

# Executables, configurable
ARIA2 ?= aria2c
DUCKDB ?= duckdb
GZIP ?= gzip
SHELL ?= /bin/bash
UNZIP ?= unzip
WGET ?= wget

# Configuration for downloader via DOWNLOADER var. Should be overridden.
DOWNLOADER ?= wget # or aria2

# TODO: Set -s and -x based on NCORES

# Configuration for downloading data files
define get_download_cmd
$(if $(filter $(1),wget),\
$(WGET) -O $@ $(URL),\
$(if $(filter $(1),aria2),\
$(ARIA2) --check-certificate=false -s4 -x16 -k1M -d $(shell echo $(dir $@) | sed 's/\/$$//') -o $(notdir $@) $(URL),\
echo "Unsupported downloader: $(1)"))
endef