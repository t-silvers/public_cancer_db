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
from read_csv('pcawg_donor_clinical_August2016_v9_sp', sep='\t');