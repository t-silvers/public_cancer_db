create table tcga_prot as 
with data_wide as (
    select 
        SampleID as gene_ensg
        , * exclude (SampleID) 
    from read_csv(
        'TCGA-RPPA-pancan-clean.xena.gz',
        sep='\t',
        sample_size=1280,
        header=True
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
    try_cast(sample_id as sample_ids) as sample_id
    , gene_ensg
    , try_cast("value" as real) as "value"
from data_long;