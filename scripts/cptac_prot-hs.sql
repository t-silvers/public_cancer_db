
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

with data_wide as (
    select 
        cast(regexp_extract("filename", '/(\w+)_proteomics', 1) as cancer_ids) as cancer
        , cast(regexp_extract("filename", 'normalized_(\w+).txt', 1) as disease_ids) as cancer_status
        , * exclude ("filename") 
    from read_csv(
        concat(getenv('data_dir'), '/', getenv('CANCER'), '/', getenv('CANCER'), '_proteomics*'),
        sep='\t',
        header=True,
        filename=True
    )
),
data_long as (
    unpivot data_wide
    on columns(* exclude ("cancer", "cancer_status", "idx"))
    into 
        name sample_id 
        value "value"
) 
insert into cptac_prot
select
    cancer
    , cancer_status
    , cast(sample_id as sample_ids) as sample_id
    -- TODO: Figure out failure source for this ENUM type
    -- , cast(idx as gene_ensg_ids) as gene_ensg
    , idx as gene_ensg
    , try_cast("value" as real) as "value"
from data_long;