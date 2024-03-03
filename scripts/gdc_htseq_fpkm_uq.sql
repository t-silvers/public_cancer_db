create table gdc_pancan_htseq_fpkm_uq as
with data_wide as (
    select
        xena_sample as gene_ensg
        , * exclude (xena_sample) 
    from read_csv(
        'GDC-PANCAN.htseq_fpkm-uq.tsv.gz',
        sep='\t',
        nullstr='nan',
        parallel=True,
        sample_size=1280
    )
),
data_long as (
    unpivot data_wide
    on columns(* exclude (gene_ensg))
    into
        name sample_id
        value 'value'
)
select 
    -- TODO: A single sample appears to not have a sample_id in sample_ids.
    sample_id
    , gene_ensg
    -- try_cast(sample_id as sample_ids) as sample_id
    -- , cast(gene_ensg as gene_ensg_ids) as gene_ensg
    , try_cast("value" as REAL) as "value"
from data_long
where 
    sample_id not like 'TARGET-%'
    and sample_id is not null;