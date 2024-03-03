create table pcawg_pheno_sample as 
select 
    icgc_specimen_id as sample_id
    , dcc_specimen_type
from read_csv('sp_specimen_type', sep='\t', header=True);