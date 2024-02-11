# Create a Peristent DuckDB Database for Public Cancer Data

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
