create table gdc_masked_cnv as 
select 
    -- cast("sample" as sample_ids) as sample_id
    -- , cast('chr' || Chrom as chrom_ids) as chrom
    "sample" as sample_id
    , 'chr' || Chrom as chrom
    , cast("Start" as UBIGINT) as chrom_start
    , cast("End" as UBIGINT) as chrom_end
    , cast("value" as REAL) as "value"
from read_csv(
    'GDC-PANCAN.masked_cnv.tsv.gz',
    sep='\t',
    parallel=True
);

alter table gdc_masked_cnv
add column "assembly" assembly_ids default 'hg38';