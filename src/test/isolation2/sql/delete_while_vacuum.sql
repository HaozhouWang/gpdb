-- @Description Ensures that a delete before a vacuum operation is ok
-- 
DROP TABLE IF EXISTS ao;
CREATE TABLE ao (a INT, b INT) WITH (appendonly=true);
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1, 100) AS i;


DELETE FROM ao WHERE a < 12;
1: BEGIN;
1: SELECT COUNT(*) FROM ao;
1>: DELETE FROM ao WHERE a < 90;COMMIT;
2: VACUUM ao;
1<:
1: SELECT COUNT(*) FROM ao;
3: INSERT INTO ao VALUES (0);
