-- @Description Ensures that an update during a vacuum operation is ok
-- 
DROP TABLE IF EXISTS ao;
CREATE TABLE ao (a INT, b INT) WITH (appendonly=true);
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;
INSERT INTO ao SELECT i as a, i as b FROM generate_series(1,1000) AS i;

DELETE FROM ao WHERE a < 128;
4: BEGIN;
4: SELECT COUNT(*) FROM ao;
5: BEGIN;
4: SELECT COUNT(*) FROM ao;
4: BEGIN;
4: SELECT COUNT(*) FROM ao;
2>: VACUUM ao;
4: SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;BEGIN;UPDATE ao SET b=1 WHERE a > 500;UPDATE ao SET b=1 WHERE a > 400;COMMIT;
2<:
3: SELECT COUNT(*) FROM ao WHERE b = 1;
3: INSERT INTO ao VALUES (0);
