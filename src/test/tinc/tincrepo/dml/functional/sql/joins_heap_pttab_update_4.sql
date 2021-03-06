-- @author prabhd 
-- @created 2012-12-05 12:00:00 
-- @modified 2012-12-05 12:00:00 
-- @tags dml 
-- @db_name dmldb
-- @execute_all_plans True
-- @description update_test4: Update to default value
\echo --start_ignore
set gp_enable_column_oriented_table=on;
\echo --end_ignore
SELECT SUM(a) FROM dml_heap_pt_r;
SELECT SUM(b) FROM dml_heap_pt_r;
ALTER TABLE dml_heap_pt_r ADD DEFAULT partition def;
UPDATE dml_heap_pt_r SET a = DEFAULT, b = DEFAULT; 
SELECT SUM(a) FROM dml_heap_pt_r;
SELECT SUM(b) FROM dml_heap_pt_r;
ALTER TABLE dml_heap_pt_r DROP DEFAULT partition;
