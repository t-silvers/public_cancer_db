
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table gdc_pancan_methylation27 as
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
    , cast("Composite Element REF" as cpg_probe_ids) as probe
    , try_cast("value" as real) as "value"
from data_long;