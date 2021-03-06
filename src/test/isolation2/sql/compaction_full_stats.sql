-- @Description Tests the behavior of full vacuum w.r.t. the pg_class statistics
-- 
DROP TABLE IF EXISTS foo;

CREATE TABLE foo (a INT, b INT, c CHAR(128)) WITH (appendonly=true) DISTRIBUTED BY (a);
CREATE INDEX foo_index ON foo(b);
INSERT INTO foo SELECT i as a, i as b, 'hello world' as c FROM generate_series(1, 50) AS i;
INSERT INTO foo SELECT i as a, i as b, 'hello world' as c FROM generate_series(51, 100) AS i;
ANALYZE foo;

-- ensure that the scan go through the index
SET enable_seqscan=false;
SELECT relname, reltuples FROM pg_class WHERE relname = 'foo';
SELECT relname, reltuples FROM pg_class WHERE relname = 'foo_index';
DELETE FROM foo WHERE a < 16;
VACUUM FULL foo;
SELECT relname, reltuples FROM pg_class WHERE relname = 'foo';
SELECT relname, reltuples FROM pg_class WHERE relname = 'foo_index';
SELECT segno, tupcount,state FROM gp_toolkit.__gp_aoseg_name('foo');
