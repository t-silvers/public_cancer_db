
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

drop type if exists assembly_ids;
drop type if exists cancer_ids;
drop type if exists chrom_ids;
drop type if exists disease_ids;
drop type if exists gene_ensg_ids;
drop type if exists gene_enst_ids;
drop type if exists gene_name_ids;
drop type if exists sample_ids;

create type assembly_ids as enum ('hg19', 'hg38');

create type cancer_ids as enum (
    'ACC', 'BLCA', 'BRCA', 'CESC', 'CHOL',
    'COAD', 'DLBC', 'ESCA', 'GBM', 'HNSC',
    'KICH', 'KIRC', 'KIRP', 'LAML', 'LGG', 
    'LIHC', 'LUAD', 'LUSC', 'MESO', 'OV', 
    'PAAD', 'PCPG', 'PRAD', 'READ', 'SARC', 
    'SKCM', 'STAD', 'TGCT', 'THCA', 'THYM', 
    'UCEC', 'UCS', 'UVM', 'GDC-PANCAN',
    'CCRCC', 'HNSCC', 'LSCC', 'PDAC'
);

create type chrom_ids as enum (
    -- Only keep chromosome, not assembly info etc.
    select distinct regexp_extract(chrom, '^(chr[0-9A-Za-z]{1,2})', 1) from (
        select chrom from read_csv(getenv('GDCPROBEMAP'), sep='\t')
        union
        select chrom from read_csv(getenv('TOILPROBEMAP'), sep='\t')
    )
);

create type cpg_probe_ids as enum (
    select probe_id from (
        select "#id" as probe_id from read_csv(getenv('GDC27MAP'), sep='\t')
        union
        select "#id" as probe_id from read_csv(getenv('GDC450MAP'), sep='\t')
    )
);

create type disease_ids as enum ('Healthy', 'Normal', 'Tumor');

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
--
-- TODO: I think these enums are hitting errors on conversion because they're
--       encoded as UINT16 under the hood, which has a max value of 65535.
--       `Error: Conversion Error: Could not convert string '<val>' to UINT16`
--       However, only e.g. 60483 unique ENSG IDs in the GDC probe...
--

create type gene_ensg_ids as enum (
    select id from read_csv(getenv('GDCPROBEMAP'), sep='\t')
);

-- TODO: Alternative ENUM type for ENSTs? (198619 unique values)
--       ... Yet casting works for some data sets ...

create type gene_enst_ids as enum (
    select id from read_csv(getenv('TOILTRANSCRIPTPROBEMAP'), sep='\t')
);

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

create type gene_name_ids as enum (
    select gene from (
        select gene from read_csv(getenv('GDCPROBEMAP'), sep='\t')
        union
        select gene from read_csv(getenv('TOILPROBEMAP'), sep='\t')
        union
        select gene from read_csv(getenv('TOILSNVS'), sep='\t')
        union
        select gene from read_csv(getenv('TOILTRANSCRIPTPROBEMAP'), sep='\t')
    )
);

create type sample_ids as enum (
    select sample_id from (
        select column0 as sample_id from read_csv(getenv('CPTACPHENO'), header=False)
        union
        select "sample" as sample_id from read_csv(getenv('GDCPHENO'), sep='\t')
        union
        select "sample" from read_csv(getenv('TOILPHENO'), sep='\t', header=true)
    )
);