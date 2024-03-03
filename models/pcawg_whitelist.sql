create table pcawg_whitelist as 
select 
    icgc_specimen_id as sample_id
    , donor_wgs_exclusion_white_gray
from read_csv(
    'sp_wgs_exclusion_white_gray',
    sep='\t',
    header=True
);