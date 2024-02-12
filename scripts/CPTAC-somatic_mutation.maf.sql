
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

-- CSV parsing fails with `union_by_name=True`, even with `auto_detect=false` and custom configuration

create table cptac_somatic_mutation_maf as 
select 
    cast(regexp_extract("filename", getenv('REGEX'), 1) as cancer_ids) as cancer
    , cast(Tumor_Sample_Barcode as sample_ids) as sample_id
    -- , cast(gene_name as gene_ensg_ids) as gene_ensg
    , gene_name as gene_ensg
    , cast(Chromosome as chrom_ids) as chrom
    , cast(Start_Position as UBIGINT) as chrom_start
    , cast(End_Position as UBIGINT) as chrom_end
    , Variant_Classification as effect
    , try_cast(TumorVAF as real) as dna_vaf
from read_csv(getenv('DATAPATH'), filename=True);