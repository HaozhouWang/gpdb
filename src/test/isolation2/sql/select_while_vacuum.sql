-- @Description Ensures that a select during a vacuum operation is ok
-- 
DROP TABLE IF EXISTS ao;
CREATE TABLE ao (a INT) WITH (appendonly=true);
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

DELETE FROM ao WHERE a < 128;
1: BEGIN;
1>: SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;COMMIT;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;SELECT COUNT(*) FROM ao;COMMIT;
2: VACUUM ao;
1<:
3: INSERT INTO ao VALUES (0);
