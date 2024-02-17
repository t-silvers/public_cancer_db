
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

with data_wide as (
    select 
        cast(regexp_extract("filename", '/(\w+)_WES_CNV_gene_ratio_log2.txt', 1) as cancer_ids) as cancer
        , * exclude ("filename")
    from read_csv(
        concat(getenv('DIR'), '/data/', getenv('CANCER'), '/', getenv('CANCER'), '_WES_CNV_gene_ratio_log2.txt'),
        sep='\t',
        header=True,
        filename=True
    )
),
data_long as (
    unpivot data_wide
    on columns(* exclude ("cancer", "idx"))
    into 
        name sample_id 
        value "value"
) 
insert into cptac_cnv
select
    cancer
    , cast(sample_id as sample_ids) as sample_id
    -- TODO: Remove .# suffix from ENSGs
    -- , cast(idx as gene_ensg_ids) as gene_ensg
    , idx as gene_ensg
    , try_cast("value" as real) as "value"
from data_long;