create table icgc_exp as 
with data_wide as (
    select 
        "sample" as gene_name
        , * exclude ("sample") 
    from read_csv(
        'sp%2Fexp_seq.all_projects.specimen.USonly.xena.tsv.gz',
        sep='\t',
        parallel=True,
        sample_size=1280
    )
),
data_long as (
    unpivot data_wide
    on columns(* exclude (gene_name))
    into
        name sample_id
        value 'value'
)
select 
    sample_id
    , try_cast(gene_name as gene_name_ids) as gene_name
    , try_cast("value" as real) as "value"
from data_long;