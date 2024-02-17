
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table icgc_exp as 
with data_wide as (
    select 
        "sample" as gene_name
        , * exclude ("sample") 
    from read_csv(
        concat(getenv('DIR'), '/data/sp%2Fexp_seq.all_projects.specimen.USonly.xena.tsv.gz'),
        sep='\t',
        sample_size=1280,
        parallel=True
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