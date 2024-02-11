
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

drop table if exists gdc_pancan_mutect2_snv;

create table gdc_pancan_mutect2_snv as
select 
    cast(Sample_ID as sample_ids) as sample_id
    -- has 'chr' prefix
    , cast(chrom as chrom_ids) as chrom
    , cast("start" as UBIGINT) as chrom_start
    , cast("end" as UBIGINT) as chrom_end
    -- Different values than in gene_name_ids ENUM
    , gene as gene_name
    , effect
    , cast(case when "filter" = 'PASS' then 1 else 0 end as BOOLEAN) as "filter"
    , cast(dna_vaf as REAL) as dna_vaf
from read_csv(getenv('DATAPATH'), sep='\t');


