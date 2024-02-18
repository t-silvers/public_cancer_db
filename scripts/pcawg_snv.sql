
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table pcawg_snv as 
select 
    "Sample" as sample_id
    , 'chr' || chr as chrom
    , cast("start" as ubigint) as chrom_start
    , cast("end" as ubigint) as chrom_end
    , gene as gene_name
    , effect
    , try_cast(DNA_VAF as real) as dna_vaf
from read_csv(
    concat(getenv('data_dir'), '/October_2016_all_patients_2778.snv_mnv_indel.maf.coding.xena'),
    nullstr='NA',
    sep='\t'
);

alter table pcawg_snv
add column "assembly" assembly_ids default 'hg19';