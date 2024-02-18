
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table pcawg_pheno_donor as 
select 
    xena_sample as sample_id
    , _PATIENT
    , try_cast(
        case
            when donor_sex ilike 'male' then '1'
            when donor_sex ilike 'female' then '0'
            else donor_sex
        end
        as BOOLEAN
    ) as sex
from read_csv(
    concat(getenv('data_dir'), '/pcawg_donor_clinical_August2016_v9_sp'),
    sep='\t'
);