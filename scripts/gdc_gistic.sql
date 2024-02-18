
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table gdc_gistic as
with data_wide as (
    select 
        -- cast(column00000 as gene_ensg_ids) as gene_ensg
        column00000 as gene_ensg
        , * exclude (column00000) 
    from read_csv(
        concat(getenv('data_dir'), '/GDC-PANCAN.gistic.tsv.gz'),
        sep='\t',
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
    -- cast(sample_id as sample_ids) as sample_id
    sample_id
    , gene_ensg
    , try_cast("value" + 1 as UTINYINT) as "value"
from data_long;