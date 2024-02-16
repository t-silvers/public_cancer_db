set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');

create table gtex_analysis_v8_annotations_subjectphenotypesds as
select
    SUBJID as subject_id
    , SEX-1 as sex
    , AGE as age_range_years
from read_csv('https://storage.googleapis.com/adult-gtex/annotations/v8/metadata-files/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt', sep='\t');