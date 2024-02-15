
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table icgc_sp_2fcopy_number_somatic_mutation_all_projects_specimen as 
select 
    sampleID as sample_id
    , 'chr' || chr as chrom
    , cast("start" as ubigint) as chrom_start
    , cast("end" as ubigint) as chrom_end
    , cast("value" as real) as "value"
from read_csv(getenv('DATAPATH'), sep='\t');

alter table icgc_sp_2fcopy_number_somatic_mutation_all_projects_specimen
add column "assembly" assembly_ids default 'hg19';