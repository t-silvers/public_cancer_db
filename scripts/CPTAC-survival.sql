
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

drop table if exists cptac_survival;

create table cptac_survival as 
select 
    try_cast(regexp_extract("filename", getenv('REGEX'), 1) as cancer_ids) as cancer
    -- TODO: Temporary to diagnose issue with casting
    , "filename"
    , cast(case_id as sample_ids) as sample_id
    , try_cast(OS_days as SMALLINT) as os_time
    , try_cast(OS_event as BOOLEAN) as os
from read_csv(getenv('DATAPATH'), sep='\t', union_by_name=True, filename=True);