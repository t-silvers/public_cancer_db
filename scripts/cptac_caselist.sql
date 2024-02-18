
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table if not exists cptac_caselist as 
select
    cast(regexp_extract("filename", '/(\w+)_(Tumor|Normal)_CaseList', 1) as cancer_ids) as cancer
    , cast(regexp_extract("filename", '_(Tumor|Normal)_CaseList.txt', 1) as disease_ids) as cancer_status
    , sample_id
from read_csv(
    concat(getenv('data_dir'), '/*/*_CaseList.txt'),
    sep='\t',
    header=False,
    columns={'sample_id': sample_ids},
    names=['sample_id'],
    filename=True
);