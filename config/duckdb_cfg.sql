.bail on
-- TODO: Doesn't work as expected
-- .cd getenv('data_dir')
.prompt 'duckdb> '

set enable_progress_bar = true;
set memory_limit = getenv('MEMORY_LIMIT');
set preserve_insertion_order = false;
set threads to getenv('NCORES');
