
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table pcawg_pheno_sample as 
select 
    icgc_specimen_id as sample_id
    , dcc_specimen_type
from read_csv(
    concat(getenv('DIR'), '/data/sp_specimen_type'),
    sep='\t',
    header=True
);