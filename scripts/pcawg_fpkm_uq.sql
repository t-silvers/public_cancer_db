
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table pcawg_fpkm_uq as 
with data_wide as (
    select 
        feature as gene_ensg
        , * exclude (feature)
    from read_csv(
        concat(getenv('DIR'), '/data/tophat_star_fpkm_uq.v2_aliquot_gl.sp.log'),
        sep='\t',
        sample_size=1280,
        parallel=True
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
    sample_id
    , gene_ensg
    , try_cast("value" as real) as "value"
from data_long;