
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table gdc_pancan_basic_phenotype as 
select 
    cast("sample" as sample_ids) as sample_id
    , sample_type
    -- No project ID, other data re-listed for entries ending with decimal
    , try_cast(regexp_extract(project_id, 'TCGA-(\w+)', 1) as cancer_ids) as cancer
    , project_id
    , try_cast(
        case
            when sample_type ilike '%normal%' then 'Normal'
            when sample_type ilike '%tumor%' then 'Tumor'
            when sample_type ilike '%metastatic%' then 'Tumor'
            else sample_type
        end
        as disease_ids
    ) as cancer_status
    , try_cast("Age at Diagnosis in Years" as UTINYINT) as age_years
    , try_cast(
        case
            when Gender = 'Male' then '1'
            when Gender = 'Female' then '0'
            else Gender
        end
        as BOOLEAN
    ) as sex
from read_csv(getenv('DATAPATH'), sep='\t')
where program != 'TARGET';