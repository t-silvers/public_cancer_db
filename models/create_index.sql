-- TODO: Need better flow control here when types exist.
drop type if exists assembly_ids;
drop type if exists cancer_ids;
drop type if exists chrom_ids;
drop type if exists cpg_probe_ids;
drop type if exists disease_ids;
drop type if exists gene_ensg_ids;
drop type if exists gene_enst_ids;
drop type if exists gene_name_ids;
drop type if exists sample_ids;

create type assembly_ids as enum ('hg19', 'hg38');

create type cancer_ids as enum (
    'ACC', 'BLCA', 'BRCA', 'CESC', 'CHOL',
    'COAD', 'DLBC', 'ESCA', 'GBM', 'HNSC',
    'KICH', 'KIRC', 'KIRP', 'LAML', 'LGG', 
    'LIHC', 'LUAD', 'LUSC', 'MESO', 'OV', 
    'PAAD', 'PCPG', 'PRAD', 'READ', 'SARC', 
    'SKCM', 'STAD', 'TGCT', 'THCA', 'THYM', 
    'UCEC', 'UCS', 'UVM', 'GDC-PANCAN',
    'CCRCC', 'HNSCC', 'LSCC', 'PDAC'
);

-- Only keep chromosome, not assembly info etc. Not sure what 'Un' is ...
create type chrom_ids as enum (
    'chr1', 'chr2', 'chr3', 'chr4', 'chr5',
    'chr6', 'chr7', 'chr8', 'chr9', 'chr10',
    'chr11', 'chr12', 'chr13', 'chr14', 'chr15',
    'chr16', 'chr17', 'chr18', 'chr19', 'chr20',
    'chr21', 'chr22', 'chrX', 'chrY', 'chrM',
    'chrUn'
);

create type cpg_probe_ids as enum (
    select probe_id from (
        select "#id" as probe_id from read_csv(
            concat('illuminaMethyl27_hg38_GDC'), sep='\t'
        )
        union
        select "#id" as probe_id from read_csv(
            concat('illuminaMethyl450_hg38_GDC'), sep='\t'
        )
    )
);

create type disease_ids as enum ('Healthy', 'Normal', 'Tumor');

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
--
-- TODO: I think these enums are hitting errors on conversion because they're
--       encoded as UINT16 under the hood, which has a max value of 65535.
--       `Error: Conversion Error: Could not convert string '<val>' to UINT16`
--       However, only e.g. 60483 unique ENSG IDs in the GDC probe...
--

create type gene_ensg_ids as enum (
    select id from read_csv('gencode.v22.annotation.gene.probeMap', sep='\t')
);

-- TODO: Alternative ENUM type for ENSTs? (198619 unique values)
--       ... Yet casting works for some data sets ...

create type gene_enst_ids as enum (
    select id from read_csv('probeMap%2Fgencode.v23.annotation.transcript.probemap', sep='\t')
);

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

create type gene_name_ids as enum (
    select gene from (
        select gene from read_csv('gencode.v22.annotation.gene.probeMap', sep='\t')
        union
        select gene from read_csv('/probeMap%2Fhugo_gencode_good_hg38_v23comp_probemap', sep='\t')
        union
        select gene from read_csv('mc3.v0.2.8.PUBLIC.toil.xena.gz', sep='\t')
        union
        select gene from read_csv('probeMap%2Fgencode.v23.annotation.transcript.probemap', sep='\t')
    )
);

create type sample_ids as enum (
    select sample_id from (
        select column0 as sample_id from read_csv('*/*_CaseList.txt', header=False)
        union
        select "sample" as sample_id from read_csv('GDC-PANCAN.basic_phenotype.tsv.gz', sep='\t')
        union
        select "sample" from read_csv('TCGA_GTEX_category.txt', sep='\t', header=true)
    )
);