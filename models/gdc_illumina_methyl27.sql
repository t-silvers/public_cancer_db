create table gdc_illumina_methyl27 as
select
    cast("#id" as cpg_probe_ids) as probe
    , try_cast(gene as gene_name_ids) as gene_name
    , try_cast(chrom as chrom_ids) as chrom
    -- Some chromStart, chromEnd are -1
    , try_cast(chromStart as UBIGINT) as chrom_start
    , try_cast(chromEnd as UBIGINT) as chrom_end
from read_csv('illuminaMethyl27_hg38_GDC', sep='\t');