
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

drop table if exists gdc_pancan_gistic;

create table gdc_pancan_gistic as
with data_wide as (
    select 
        cast(column00000 as gene_ensg_ids) as gene_ensg 
        , * exclude (column00000) 
    from read_csv(getenv('DATAPATH'), sep='\t', sample_size = 1280, parallel = True) 
),
data_long as (
    unpivot data_wide
    on columns(* exclude (gene_ensg))
    into
        name sample_id
        value 'value'
)
select
    cast(sample_id as sample_ids) as sample_id
    , gene_ensg
    , try_cast("value" + 1 as UTINYINT) as "value"
from data_long;