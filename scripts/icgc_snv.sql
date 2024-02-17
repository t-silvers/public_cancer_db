
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table icgc_snv as 
select 
    "sample" as sample_id
    , 'chr' || chr as chrom
    , cast("start" as ubigint) as chrom_start
    , cast("end" as ubigint) as chrom_end
    , effect
    , gene as gene_name
from read_csv(
    concat(getenv('DIR'), '/data/sp%2FSNV.sp.codingMutation-allProjects.gz'),
    sep='\t'
);

alter table icgc_snv
add column "assembly" assembly_ids default 'hg19';