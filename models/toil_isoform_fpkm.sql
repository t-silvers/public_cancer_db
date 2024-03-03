create table toil_isoform_fpkm as
with data_wide as (
    select 
        "sample" as gene_enst
        , * exclude ("sample")
    from read_csv(
        'TcgaTargetGtex_RSEM_isoform_fpkm.gz',
        sep='\t',
        parallel=True,
        sample_size=1280
    ) 
),
data_long as (
    unpivot data_wide
    on columns(* exclude (gene_enst))
    into
        name sample_id
        value 'value'
)
select
    -- TARGET samples will be NULL
    try_cast(sample_id as sample_ids) as sample_id
    , cast(gene_enst as gene_enst_ids) as gene_enst
    , cast("value" as REAL) as "value"
from data_long
where sample_id is not null;
