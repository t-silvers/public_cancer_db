
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table pcawg_purity as 
select 
    samplename as sample_id
    , * exclude (samplename)
from read_csv(
    concat(getenv('DIR'), '/data/consensus.20170217.purity.ploidy_sp'),
    sep='\t'
);