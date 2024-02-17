
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table gdc_cnv as 
select 
    -- cast("sample" as sample_ids) as sample_id
    -- , cast('chr' || Chrom as chrom_ids) as chrom
    "sample" as sample_id
    , 'chr' || Chrom as chrom
    , cast("Start" as UBIGINT) as chrom_start
    , cast("End" as UBIGINT) as chrom_end
    , cast("value" as REAL) as "value"
from read_csv(concat(getenv('DIR'), '/data/GDC-PANCAN.cnv.tsv.gz'), sep='\t');

alter table gdc_cnv
add column "assembly" assembly_ids default 'hg38';