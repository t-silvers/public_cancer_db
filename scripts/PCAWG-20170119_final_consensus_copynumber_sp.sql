
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table pcawg_20170119_final_consensus_copynumber_sp as 
select 
    sampleID as sample_id
    , 'chr' || chr as chrom
    , cast("start" as ubigint) as chrom_start
    , cast("end" as ubigint) as chrom_end
    , cast("value" as ubigint) as "value"
    , case
        when star = '3' then 'clonal_agreement'
        when star = '2' then 'rounding_agreement_or_majority'
        when star = '1' then 'best_method'
        else null
    end as star_eval
from read_csv(getenv('DATAPATH'), sep='\t');

alter table pcawg_20170119_final_consensus_copynumber_sp
add column "assembly" assembly_ids default 'hg19';