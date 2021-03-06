-- @Description Tests the compaction of data inserted in utility mode
-- 
DROP TABLE IF EXISTS foo;
CREATE TABLE foo (a INT, b INT, c CHAR(128)) WITH (appendonly=true) distributed randomly;
CREATE INDEX foo_index ON foo(b);

INSERT INTO foo VALUES (1, 1, 'c');
SELECT segno, tupcount, state FROM gp_toolkit.__gp_aoseg_name('foo');
2U: INSERT INTO foo VALUES (2, 2, 'c');
2U: INSERT INTO foo VALUES (3, 3, 'c');
2U: SELECT segno, tupcount, state FROM gp_toolkit.__gp_aoseg_name('foo') where segno = 0;
-- We know that the master does update its tupcount yet
SELECT segno, tupcount, state FROM gp_toolkit.__gp_aoseg_name('foo');
DELETE FROM foo WHERE a = 2;
UPDATE foo SET b = -1 WHERE a = 3;
VACUUM foo;
2U: SELECT segno, tupcount, state FROM gp_toolkit.__gp_aoseg_name('foo') where segno = 0;
SELECT segno, tupcount, state FROM gp_toolkit.__gp_aoseg_name('foo');
