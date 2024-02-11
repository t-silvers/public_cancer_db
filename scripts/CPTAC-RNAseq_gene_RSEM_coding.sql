
drop table if exists cptac_rnaseq_gene_rsem_coding;

create table cptac_rnaseq_gene_rsem_coding (cancer cancer_ids, cancer_status varchar, sample_id sample_ids, gene_ensg gene_ensg_ids, "value" REAL);