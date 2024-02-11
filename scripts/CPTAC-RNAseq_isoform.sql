
drop table if exists cptac_rnaseq_isoform;

-- create table cptac_rnaseq_isoform (cancer cancer_ids, cancer_status varchar, sample_id sample_ids, gene_enst gene_enst_ids, "value" REAL);

create table cptac_rnaseq_isoform (cancer cancer_ids, cancer_status varchar, sample_id varchar, gene_enst varchar, "value" REAL);