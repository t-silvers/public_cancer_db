# Create a Peristent DuckDB Database for Public Cancer Data

## Description


Build a DuckDB database for performant querying of publicly available cancer data. Code is in a functional state for use in personal projects. While it works as intended, it includes several quick and dirty implementations.

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

### Note on Concurrency

Quoting from the [DuckDB docs on concurrency](https://duckdb.org/docs/connect/concurrency.html),

> DuckDB has two configurable options for concurrency:
> 1. One process can both read and write to the database.
> 2. Multiple processes can read from the database, but no processes can write (access_mode = 'READ_ONLY').
> When using option 1, DuckDB supports multiple writer threads ...

To benefit from `make` parallelism, the database can be built in two steps using phony targets,

```bash
echo "Fetching data ..."
make fetch_data -C /path/to/public_cancer_db -j 8

echo "Building database ..."
make make_databases -C /path/to/public_cancer_db -j 1
```

where `NCORES`, etc. can be configured separately to best utilize available resources for multi-threaded database writes.