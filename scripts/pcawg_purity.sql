create table pcawg_purity as 
select 
    samplename as sample_id
    , * exclude (samplename)
from read_csv('consensus.20170217.purity.ploidy_sp', sep='\t');