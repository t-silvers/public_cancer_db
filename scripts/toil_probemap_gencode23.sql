
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table toil_probemap_gencode23 as
select
    cast(id as gene_enst_ids) as gene_enst
    , cast(gene as gene_name_ids) as gene_name
    -- Don't cast chroms here for _chrom, some are not valid (have contig info, etc.)
    , chrom as _chrom
    , cast(regexp_extract(chrom, '^(chr[0-9A-Za-z]{1,2})', 1) as chrom_ids) as chrom
    , cast(chromStart as UBIGINT) as chrom_start
    , cast(chromEnd as UBIGINT) as chrom_end
from read_csv(
    concat(getenv('DIR'), '/data/probeMap%2Fgencode.v23.annotation.transcript.probemap'),
    sep='\t'
);