
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

drop table if exists gencode_v22_annotation_gene_probemap;

create table gencode_v22_annotation_gene_probemap as
select
    cast(id as gene_ensg_ids) as gene_ensg
    , cast(gene as gene_name_ids) as gene_name
    -- Don't cast chroms here, some are not valid
    , chrom as _chrom
    , cast(regexp_extract(chrom, '^(chr[0-9A-Za-z]{1,2})', 1) as chrom_ids) as chrom
    , cast(chromStart as UBIGINT) as chrom_start
    , cast(chromEnd as UBIGINT) as chrom_end
from read_csv(getenv('DATAPATH'), sep='\t');