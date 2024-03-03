create table icgc_cnv as 
select 
    sampleID as sample_id
    , 'chr' || chr as chrom
    , cast("start" as ubigint) as chrom_start
    , cast("end" as ubigint) as chrom_end
    , cast("value" as real) as "value"
from read_csv(
    'sp%2Fcopy_number_somatic_mutation.all_projects.specimen.gz',
    sep='\t',
    parallel=True,
    sample_size=1280
)
order by chrom_start;

alter table icgc_cnv
add column "assembly" assembly_ids default 'hg19';