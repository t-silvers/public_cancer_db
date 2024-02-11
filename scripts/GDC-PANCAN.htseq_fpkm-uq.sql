
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

-- https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.htseq_fpkm-uq.tsv.gz

drop table if exists gdc_pancan_htseq_fpkm_uq;

create table gdc_pancan_htseq_fpkm_uq as
with data_wide as (
    select 
        xena_sample as gene_ensg
        , * exclude (xena_sample) 
    from read_csv(getenv('DATAPATH'), sep='\t', nullstr='nan', sample_size=1280, parallel=True)
),
data_long as (
    unpivot data_wide
    on columns(* exclude (gene_ensg))
    into
        name sample_id
        value 'value'
)
select 
    try_cast(sample_id as sample_ids) as sample_id
    , cast(gene_ensg as gene_ensg_ids) as gene_ensg
    , try_cast("value" as REAL) as "value"
from data_long
where sample_id not like 'TARGET-%';