create table pcawg_fpkm_uq as 
with data_wide as (
    select 
        feature as gene_ensg
        , * exclude (feature)
    from read_csv(
        'tophat_star_fpkm_uq.v2_aliquot_gl.sp.log',
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
    sample_id
    , gene_ensg
    , try_cast("value" as real) as "value"
from data_long;