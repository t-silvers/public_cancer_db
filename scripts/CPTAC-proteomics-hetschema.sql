
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

-- create table cptac_proteomics (project_id varchar, cancer_status varchar, sample_id sample_ids, gene_ensg gene_ensg_ids, "value" float);

with data_wide as (
    select 
        try_cast(regexp_extract("filename", '/(\w+)_proteomics', 1) as cancer_ids) as cancer
        , regexp_extract("filename", 'normalized_(\w+).txt', 1) as cancer_status
        , * exclude ("filename") 
    from read_csv(getenv('DATAPATH'), sep='\t', header=True, filename=True)
),
data_long as (
    unpivot data_wide
    on columns(* exclude ("cancer", "cancer_status", "idx"))
    into 
        name sample_id 
        value "value"
) 
insert into cptac_proteomics
select
    cancer
    , cancer_status
    , cast(sample_id as sample_ids) as sample_id
    , cast(idx as gene_ensg_ids) as gene_ensg
    , try_cast("value" as REAL) as "value"
from data_long;