# Create a Peristent DuckDB Database for Public Cancer Data

## Description


A package to create a DuckDB database for quick querying of publicly available cancer data. Code is in a functional state for use in personal projects. While it works as intended, it includes several quick and dirty implementations.

## Data Sources

- [GDC data](https://gdc.cancer.gov) via [UCSC Xena](https://xenabrowser.net/datapages)
- [PDC data](https://proteomic.datacommons.cancer.gov/pdc/) via [LinkedOmicsKB](https://kb.linkedomics.org/download)

Consult links for details on data collection, processing, and guidelines on usage.

## Prerequisites

- `aria2` (optional) [[docs](https://aria2.github.io) (fallback: `wget`)]
- DuckDB [[docs](https://duckdb.org)]
- `make`
- `wget`

## Usage

```bash
make -C /path/to/public_cancer_db
```

With custom configuration:

```bash
make -C /path/to/public_cancer_db DATA="/path/to/large_data_storage" MEMORY_LIMIT=32GB NCORES=16 DOWNLOADER=aria2
```

Adding GDC data to an existing database:

```bash
make gdc -C /path/to/public_cancer_db DB="/path/to/data.db"
```
