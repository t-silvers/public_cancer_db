
drop table if exists cptac_wes_cnv_gene_ratio;

-- create table cptac_wes_cnv_gene_ratio (cancer cancer_ids, sample_id sample_ids, gene_ensg gene_ensg_ids, "value" REAL);

create table cptac_wes_cnv_gene_ratio (cancer cancer_ids, sample_id varchar, gene_ensg varchar, "value" REAL);