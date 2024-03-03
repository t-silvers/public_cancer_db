create table pcawg_cnv as 
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
from read_csv(
    '20170119_final_consensus_copynumber_sp',
    nullstr='NA',
    sep='\t'
)
order by chrom_start;

alter table pcawg_cnv
add column "assembly" assembly_ids default 'hg19';