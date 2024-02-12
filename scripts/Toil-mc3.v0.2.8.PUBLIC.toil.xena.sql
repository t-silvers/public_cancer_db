
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table toil_mc3_v0_2_8_public_toil_xena as 
select 
    cast("sample" as sample_ids) as sample_id
    , cast('chr' || chr as chrom_ids) as chrom
    , cast("start" as UBIGINT) as chrom_start
    , cast("end" as UBIGINT) as chrom_end
    , cast(gene as gene_name_ids) as gene_name
    , effect
    , cast(DNA_VAF as REAL) as dna_vaf
    , SIFT as sift
    , PolyPhen as poly_phen
from read_csv(getenv('DATAPATH'), sep='\t');

alter table toil_mc3_v0_2_8_public_toil_xena
add column "assembly" assembly_ids default 'hg19';