create table toil_probemap_hugo as
select
    cast(gene as gene_name_ids) as gene_name_id
    -- Don't cast chroms here for _chrom, some are not valid (have contig info, etc.)
    , chrom as _chrom
    , cast(regexp_extract(chrom, '^(chr[0-9A-Za-z]{1,2})', 1) as chrom_ids) as chrom
    , cast(chromStart as UBIGINT) as chrom_start
    , cast(chromEnd as UBIGINT) as chrom_end
from read_csv('probeMap%2Fhugo_gencode_good_hg38_v23comp_probemap', sep='\t');