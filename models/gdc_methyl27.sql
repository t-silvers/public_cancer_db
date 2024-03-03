create table gdc_methyl27 as
with data_wide as (
    select
        cast("Composite Element REF" as cpg_probe_ids) as probe
        , * exclude ("Composite Element REF")
    from read_csv(
        'GDC-PANCAN.methylation27.tsv.gz',
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