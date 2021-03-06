-- @Description Ensures that an alter table while a vacuum operation is ok
-- 
DROP TABLE IF EXISTS ao;

CREATE TABLE ao (a INT, b INT) WITH (appendonly=true);
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1, 100000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1, 100000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1, 100000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1, 100000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1, 100000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1, 100000) AS i;

DELETE FROM ao WHERE a < 12000;
1: SELECT COUNT(*) FROM ao;
2: set debug_appendonly_print_compaction=true;
2>: VACUUM ao;
1: Alter table ao set with ( reorganize='true') distributed randomly;
2<:
1: SELECT COUNT(*) FROM ao WHERE a < 12010;
