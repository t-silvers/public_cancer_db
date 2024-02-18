
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table tcga_survival as 
select 
    try_cast("sample" as sample_ids) as sample_id
    , _PATIENT as patient
    , cast("cancer type abbreviation" as cancer_ids) as cancer
    , try_cast(age_at_initial_pathologic_diagnosis as UTINYINT) as age_years
    , try_cast(
        case
            when gender ilike 'male' then '1'
            when gender ilike 'female' then '0'
            else gender
        end
        as BOOLEAN
    ) as sex
    , race
    , ajcc_pathologic_tumor_stage
    , clinical_stage
    , histological_type
    , histological_grade
    , initial_pathologic_dx_year
    , menopause_status
    , try_cast("OS.time" as smallint) as os_time
    , try_cast(OS as boolean) as os
    , try_cast("DSS.time" as smallint) as dss_time
    , try_cast(DSS as boolean) as dss
    , try_cast("DFI.time" as smallint) as dfi_time
    , try_cast(DFI as boolean) as dfi
    , try_cast("PFI.time" as smallint) as pfi_time
    , try_cast(PFI as boolean) as pfi
    , cast(
        case
            when Redaction = 'Redacted' then 1
            else 0
        end
        as BOOLEAN
    ) as redacted
from read_csv(
    concat(getenv('data_dir'), '/Survival_SupplementalTable_S1_20171025_xena_sp'),
    sep='\t'
);