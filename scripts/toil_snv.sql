
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table toil_snv as 
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
from read_csv(
    concat(getenv('DIR'), '/data/mc3.v0.2.8.PUBLIC.toil.xena.gz'),
    sep='\t'
);

alter table toil_snv
add column "assembly" assembly_ids default 'hg19';