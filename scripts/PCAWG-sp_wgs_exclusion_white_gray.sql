
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table pcawg_sp_wgs_exclusion_white_gray as 
select 
    icgc_specimen_id as sample_id
    , donor_wgs_exclusion_white_gray
from read_csv(getenv('DATAPATH'), sep='\t', header=True);