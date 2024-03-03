-- CSV parsing fails with `union_by_name=True`, even with `auto_detect=false` and custom configuration

create table cptac_snv as 
select 
    try_cast(regexp_extract("filename", '/(\w+)_somatic_mutation.maf', 1) as cancer_ids) as cancer
    , try_cast(Tumor_Sample_Barcode as sample_ids) as sample_id
    -- , cast(gene_name as gene_ensg_ids) as gene_ensg
    , gene_name as gene_ensg
    , try_cast(Chromosome as chrom_ids) as chrom
    , try_cast(Start_Position as UBIGINT) as chrom_start
    , try_cast(End_Position as UBIGINT) as chrom_end
    , Variant_Classification as effect
    , try_cast(TumorVAF as real) as dna_vaf
from read_csv('/*/*_somatic_mutation.maf', filename=True);