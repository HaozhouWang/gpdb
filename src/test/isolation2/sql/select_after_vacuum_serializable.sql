-- @Description Ensures that a serializable select before during a vacuum operation blocks the vacuum.
-- 
DROP TABLE IF EXISTS ao;
DROP TABLE IF EXISTS ao2;
CREATE TABLE ao (a INT) WITH (appendonly=true);
CREATE TABLE ao2 (a INT) WITH (appendonly=true);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao select generate_series(1,1000);
insert into ao2 select generate_series(1,1000);

DELETE FROM ao WHERE a < 128;
1: BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
1: SELECT COUNT(*) FROM ao2;
2: VACUUM ao;
1: SELECT COUNT(*) FROM ao;
1: COMMIT;
3: INSERT INTO ao VALUES (0);
