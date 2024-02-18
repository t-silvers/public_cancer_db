
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table gdc_methyl450 as
with data_wide as (
    select *
    from read_csv(
        concat(getenv('data_dir'), '/GDC-PANCAN.methylation450.tsv.gz'),
        sep='\t',
        parallel=True,
        sample_size=1280
    )
),
data_long as (
    unpivot data_wide
    on columns(* exclude ("Composite Element REF"))
    into
        name sample_id
        value 'value'
)
select
    -- try_cast(sample_id as sample_ids) as sample_id
    -- , try_cast("Composite Element REF" as cpg_probe_ids) as probe
    sample_id
    , "Composite Element REF" as probe
    , "value"
    -- , cast("value" as real) as "value"
from data_long;