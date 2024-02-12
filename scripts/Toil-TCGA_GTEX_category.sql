
set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

-- TODO: Revise harmonized tissue types

create table toil_tcga_gtex_category as
select 
    cast("sample" as sample_ids) as sample_id
    , case 
        when TCGA_GTEX_main_category = 'GTEX Adipose Tissue' then 'adipose'
        when TCGA_GTEX_main_category = 'GTEX Adrenal Gland' then 'adrenal'
        when TCGA_GTEX_main_category = 'GTEX Bladder' then 'bladder'
        when TCGA_GTEX_main_category = 'GTEX Blood' then 'blood'
        when TCGA_GTEX_main_category = 'GTEX Blood Vessel' then 'blood vessel'
        when TCGA_GTEX_main_category = 'GTEX Brain' then 'brain'
        when TCGA_GTEX_main_category = 'GTEX Breast' then 'breast'
        when TCGA_GTEX_main_category = 'GTEX Cervix Uteri' then 'cervix'
        when TCGA_GTEX_main_category = 'GTEX Colon' then 'colon'
        when TCGA_GTEX_main_category = 'GTEX Esophagus' then 'esophagus'
        when TCGA_GTEX_main_category = 'GTEX Fallopian Tube' then 'gyn'
        when TCGA_GTEX_main_category = 'GTEX Heart' then 'heart'
        when TCGA_GTEX_main_category = 'GTEX Kidney' then 'kidney'
        when TCGA_GTEX_main_category = 'GTEX Liver' then 'liver'
        when TCGA_GTEX_main_category = 'GTEX Lung' then 'lung'
        when TCGA_GTEX_main_category = 'GTEX Muscle' then 'muscle'
        when TCGA_GTEX_main_category = 'GTEX Nerve' then 'nerve'
        when TCGA_GTEX_main_category = 'GTEX Ovary' then 'gyn'
        when TCGA_GTEX_main_category = 'GTEX Pancreas' then 'pancreas'
        when TCGA_GTEX_main_category = 'GTEX Pituitary' then 'pituitary'
        when TCGA_GTEX_main_category = 'GTEX Prostate' then 'prostate'
        when TCGA_GTEX_main_category = 'GTEX Salivary Gland' then 'salivary gland'
        when TCGA_GTEX_main_category = 'GTEX Skin' then 'skin'
        when TCGA_GTEX_main_category = 'GTEX Small Intestine' then 'digestive'
        when TCGA_GTEX_main_category = 'GTEX Spleen' then 'spleen'
        when TCGA_GTEX_main_category = 'GTEX Stomach' then 'digestive'
        when TCGA_GTEX_main_category = 'GTEX Testis' then 'testis'
        when TCGA_GTEX_main_category = 'GTEX Thyroid' then 'thyroid'
        when TCGA_GTEX_main_category = 'GTEX Uterus' then 'uterus'
        when TCGA_GTEX_main_category = 'GTEX Vagina' then 'vagina'
        when TCGA_GTEX_main_category = 'TCGA Acute Myeloid Leukemia' then 'blood'
        when TCGA_GTEX_main_category = 'TCGA Adrenocortical Cancer' then 'adrenal'
        when TCGA_GTEX_main_category = 'TCGA Bladder Urothelial Carcinoma' then 'bladder'
        when TCGA_GTEX_main_category = 'TCGA Brain Lower Grade Glioma' then 'brain'
        when TCGA_GTEX_main_category = 'TCGA Breast Invasive Carcinoma' then 'breast'
        when TCGA_GTEX_main_category = 'TCGA Cervical & Endocervical Cancer' then 'cervix'
        when TCGA_GTEX_main_category = 'TCGA Cholangiocarcinoma' then 'liver'
        when TCGA_GTEX_main_category = 'TCGA Colon Adenocarcinoma' then 'colon'
        when TCGA_GTEX_main_category = 'TCGA Diffuse Large B-Cell Lymphoma' then 'blood'
        when TCGA_GTEX_main_category = 'TCGA Esophageal Carcinoma' then 'esophagus'
        when TCGA_GTEX_main_category = 'TCGA Glioblastoma Multiforme' then 'brain'
        when TCGA_GTEX_main_category = 'TCGA Head & Neck Squamous Cell Carcinoma' then 'head and neck'
        when TCGA_GTEX_main_category = 'TCGA Kidney Chromophobe' then 'kidney'
        when TCGA_GTEX_main_category = 'TCGA Kidney Clear Cell Carcinoma' then 'kidney'
        when TCGA_GTEX_main_category = 'TCGA Kidney Papillary Cell Carcinoma' then 'kidney'
        when TCGA_GTEX_main_category = 'TCGA Liver Hepatocellular Carcinoma' then 'liver'
        when TCGA_GTEX_main_category = 'TCGA Lung Adenocarcinoma' then 'lung'
        when TCGA_GTEX_main_category = 'TCGA Lung Squamous Cell Carcinoma' then 'lung'
        when TCGA_GTEX_main_category = 'TCGA Mesothelioma' then 'lung'
        when TCGA_GTEX_main_category = 'TCGA Ovarian Serous Cystadenocarcinoma' then 'gyn'
        when TCGA_GTEX_main_category = 'TCGA Pancreatic Adenocarcinoma' then 'pancreas'
        when TCGA_GTEX_main_category = 'TCGA Pheochromocytoma & Paraganglioma' then 'adrenal'
        when TCGA_GTEX_main_category = 'TCGA Prostate Adenocarcinoma' then 'prostate'
        when TCGA_GTEX_main_category = 'TCGA Rectum Adenocarcinoma' then 'colon'
        when TCGA_GTEX_main_category = 'TCGA Sarcoma' then 'bone'
        when TCGA_GTEX_main_category = 'TCGA Skin Cutaneous Melanoma' then 'skin'
        when TCGA_GTEX_main_category = 'TCGA Stomach Adenocarcinoma' then 'digestive'
        when TCGA_GTEX_main_category = 'TCGA Testicular Germ Cell Tumor' then 'testis'
        when TCGA_GTEX_main_category = 'TCGA Thymoma' then 'thymus'
        when TCGA_GTEX_main_category = 'TCGA Thyroid Carcinoma' then 'thyroid'
        when TCGA_GTEX_main_category = 'TCGA Uterine Carcinosarcoma' then 'uterus'
        when TCGA_GTEX_main_category = 'TCGA Uterine Corpus Endometrioid Carcinoma' then 'uterus'
        when TCGA_GTEX_main_category = 'TCGA Uveal Melanoma' then 'eye'        
        else null
    end as tissue
    , TCGA_GTEX_main_category AS tissue_category
from read_csv(getenv('DATAPATH'), sep='\t', header=true);