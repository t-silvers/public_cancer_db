create table cptac_meta as 
select 
    try_cast(regexp_extract("filename", '/(\w+)_meta.txt', 1) as cancer_ids) as cancer
    , try_cast(case_id as sample_ids) as sample_id
    , try_cast(nullif(Age, 'NA') as UTINYINT) as age_years
    , try_cast(
        case
            when Sex = 'Male' then '1'
            when Sex = 'Female' then '0'
            else Sex
        end
        as BOOLEAN
    ) as sex
from read_csv(
    '/*/*_meta.txt',
    sep='\t',
    skip=0,
    header=True,
    union_by_name=True,
    filename=True
)
where case_id != 'data_type';