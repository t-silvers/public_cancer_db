
-- Not used

set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

drop table if exists gdc_pancan_survival;

create table gdc_pancan_survival as
select 
    cast("sample" as sample_ids) as sample_id
    , try_cast(OS as BOOLEAN) as os
    , try_cast("OS.time" as SMALLINT) as os_time
from read_csv(getenv('DATAPATH'), sep='\t');