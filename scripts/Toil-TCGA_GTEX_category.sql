
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

drop table if exists toil_tcga_gtex_category;

create table toil_tcga_gtex_category as
select 
    cast("sample" as sample_ids) as sample_id
    , TCGA_GTEX_main_category AS tissue_category
from read_csv(getenv('DATAPATH'), sep='\t', header=true)