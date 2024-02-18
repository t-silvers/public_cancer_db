
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table gdc_pheno as 
select 
    -- cast("sample" as sample_ids) as sample_id
    "sample" as sample_id
    , sample_type
    -- No project ID, other data re-listed for entries ending with decimal
    , regexp_extract(project_id, 'TCGA-(\w+)', 1) as cancer
    -- , try_cast(regexp_extract(project_id, 'TCGA-(\w+)', 1) as cancer_ids) as cancer
    , project_id
    , sample_type as cancer_status
    -- , try_cast(
    --     case
    --         when sample_type ilike '%normal%' then 'Normal'
    --         when sample_type ilike '%tumor%' then 'Tumor'
    --         when sample_type ilike '%metastatic%' then 'Tumor'
    --         else sample_type
    --     end
    --     as disease_ids
    -- ) as cancer_status
    , try_cast("Age at Diagnosis in Years" as UTINYINT) as age_years
    , try_cast(
        case
            when Gender = 'Male' then '1'
            when Gender = 'Female' then '0'
            else Gender
        end
        as BOOLEAN
    ) as sex
from read_csv(
    concat(getenv('data_dir'), '/GDC-PANCAN.basic_phenotype.tsv.gz'),
    sep='\t'
)
where program != 'TARGET';