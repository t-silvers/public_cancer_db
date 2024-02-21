
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table gdc_methyl27 as
with data_wide as (
    select
        cast("Composite Element REF" as cpg_probe_ids) as probe
        , * exclude ("Composite Element REF")
    from read_csv(
        concat(getenv('data_dir'), '/GDC-PANCAN.methylation27.tsv.gz'),
        sep='\t',
        parallel=True,
        sample_size=1280
    )
),
data_long as (
    unpivot data_wide
    on columns(* exclude (probe))
    into
        name sample_id
        value 'value'
)
select
    cast(sample_id as sample_ids) as sample_id
    , probe
    , cast("value" as real) as "value"
from data_long;