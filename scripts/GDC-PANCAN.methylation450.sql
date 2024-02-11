
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

-- https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.methylation450.tsv.gz

drop table if exists gdc_pancan_methylation450;

create table gdc_pancan_methylation450 as
with data_wide as (
    select *
    from read_csv(getenv('DATAPATH'), sep='\t', sample_size = 1280, parallel = True) 
),
data_long as (
    unpivot data_wide
    on columns(* exclude ("Composite Element REF"))
    into
        name sample_id
        value 'value'
)
select
    cast(sample_id as sample_ids) as sample_id
    , "Composite Element REF" as probe
    , "value"
from data_long;