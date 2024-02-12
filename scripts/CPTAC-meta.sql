
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table cptac_meta as 
select 
    cast(regexp_extract("filename", getenv('REGEX'), 1) as cancer_ids) as cancer
    , cast(case_id as sample_ids) as sample_id
    , cast(nullif(Age, 'NA') as UTINYINT) as age_years
    , try_cast(
        case
            when Sex = 'Male' then '1'
            when Sex = 'Female' then '0'
            else Sex
        end
        as BOOLEAN
    ) as sex
from read_csv(getenv('DATAPATH'), sep='\t', skip=0, header=True, union_by_name=True, filename=True)
where case_id != 'data_type';