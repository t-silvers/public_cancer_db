create table toil_hugo_count as
with data_wide as (
    select 
        "sample" as gene_name
        , * exclude ("sample")
    from read_csv(
        'TcgaTargetGtex_RSEM_Hugo_norm_count.gz',
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
    -- TARGET samples will be NULL
    try_cast(sample_id as sample_ids) as sample_id
    , cast(gene_name as gene_name_ids) as gene_name
    , cast("value" as REAL) as "value"
from data_long
where sample_id is not null;

alter table toil_hugo_count
add column "assembly" assembly_ids default 'hg19';