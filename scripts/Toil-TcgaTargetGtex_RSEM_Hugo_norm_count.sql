
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

-- https://toil-xena-hub.s3.us-east-1.amazonaws.com/download/TcgaTargetGtex_RSEM_Hugo_norm_count.gz

drop table if exists toil_tcgatargetgtex_rsem_hugo_norm_count;

create table toil_tcgatargetgtex_rsem_hugo_norm_count as
with data_wide as (
    select 
        "sample" as gene_name
        , * exclude ("sample")
    from read_csv(getenv('DATAPATH'), sep='\t', sample_size = 1280, parallel = True) 
),
data_long as (
    unpivot data_wide
    on columns(* exclude (gene_name))
    into
        name sample_id
        value 'value'
)
select
    -- cast(sample_id as sample_ids) as sample_id
    sample_id
    , cast(gene_name as gene_name_ids) as gene_name
    , cast("value" as REAL) as "value"
from data_long;

alter table toil_tcgatargetgtex_rsem_hugo_norm_count
add column "assembly" assembly_ids default 'hg19';