with data_wide as (
    select 
        cast(regexp_extract("filename", '/(\w+)_RNAseq_isoform_FPKM_log2_', 1) as cancer_ids) as cancer
        , cast(regexp_extract("filename", 'log2_(\w+).txt', 1) as disease_ids) as cancer_status
        , * exclude ("filename") 
    from read_csv(
        concat(getenv('CANCER'), '/', getenv('CANCER'), '_RNAseq_isoform_FPKM_log2_*'),
        sep='\t',
        header=True,
        filename=True,
        parallel=True
    )
),
data_long as (
    unpivot data_wide
    on columns(* exclude ("cancer", "cancer_status", "idx"))
    into 
        name sample_id 
        value "value"
) 
insert into cptac_exp_isoform
select
    cancer
    , cancer_status
    , cast(sample_id as sample_ids) as sample_id
    -- , cast(idx as gene_enst_ids) as gene_enst
    , idx as gene_enst
    , try_cast("value" as real) as "value"
from data_long;