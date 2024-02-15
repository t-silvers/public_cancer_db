
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table pcawg_october_2016_all_patients_2778_snv_mnv_indel_maf_coding_xena as 
select 
    "Sample" as sample_id
    , 'chr' || chr as chrom
    , cast("start" as ubigint) as chrom_start
    , cast("end" as ubigint) as chrom_end
    , gene as gene_name
    , effect
    , cast(DNA_VAF as real) as dna_vaf
from read_csv(getenv('DATAPATH'), sep='\t');

alter table pcawg_october_2016_all_patients_2778_snv_mnv_indel_maf_coding_xena
add column "assembly" assembly_ids default 'hg19';