create table icgc_pheno as 
select 
    icgc_specimen_id as sample_id
    , project_code
    , specimen_type
    , tumour_grade
    , tumour_stage
from read_csv('sp%2Fspecimen.all_projects.tsv.gz', sep='\t');