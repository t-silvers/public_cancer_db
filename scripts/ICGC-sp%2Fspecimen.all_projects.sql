
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table icgc_sp_2Fspecimen_all_projects as 
select 
    icgc_specimen_id as sample_id
    , project_code
    , specimen_type
    , tumour_grade
    , tumour_stage
from read_csv(getenv('DATAPATH'), sep='\t');