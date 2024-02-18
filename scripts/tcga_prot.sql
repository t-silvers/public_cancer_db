
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table tcga_prot as 
with data_wide as (
    select 
        SampleID as gene_ensg
        , * exclude (SampleID) 
    from read_csv(
        concat(getenv('data_dir'), '/TCGA-RPPA-pancan-clean.xena.gz'),
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