
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table pcawg_consensus_20170217_purity_ploidy_sp as 
select 
    samplename as sample_id
    , * exclude (samplename)
from read_csv(getenv('DATAPATH'), sep='\t');