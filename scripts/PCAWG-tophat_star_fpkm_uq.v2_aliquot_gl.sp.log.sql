
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table pcawg_tophat_star_fpkm_uq_v2_aliquot_gl_sp_log as 
with data_wide as (
    select 
        feature as gene_ensg
        , * exclude (feature)
    from read_csv(getenv('DATAPATH'), sep='\t', sample_size=1280, parallel=True)
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