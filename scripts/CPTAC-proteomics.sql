
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

drop table if exists cptac_proteomics;

-- create table cptac_proteomics (cancer cancer_ids, cancer_status varchar, sample_id sample_ids, gene_ensg gene_ensg_ids, "value" REAL);

create table cptac_proteomics (cancer cancer_ids, cancer_status varchar, sample_id varchar, gene_ensg varchar, "value" REAL);