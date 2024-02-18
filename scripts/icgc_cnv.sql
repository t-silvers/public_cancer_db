
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table icgc_cnv as 
select 
    sampleID as sample_id
    , 'chr' || chr as chrom
    , cast("start" as ubigint) as chrom_start
    , cast("end" as ubigint) as chrom_end
    , cast("value" as real) as "value"
from read_csv(
    concat(getenv('data_dir'), '/sp%2Fcopy_number_somatic_mutation.all_projects.specimen.gz'),
    sep='\t',
    parallel=True,
    sample_size=1280
);

alter table icgc_cnv
add column "assembly" assembly_ids default 'hg19';