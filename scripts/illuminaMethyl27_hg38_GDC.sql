
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table illuminaMethyl27_hg38_GDC as
select
    cast("#id" as cpg_probe_ids) as probe
    , try_cast(gene as gene_name_ids) as gene_name
    , try_cast(chrom as chrom_ids) as chrom
    , cast(chromStart as UBIGINT) as chrom_start
    , cast(chromEnd as UBIGINT) as chrom_end
from read_csv(getenv('DATAPATH'), sep='\t');