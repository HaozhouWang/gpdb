-- @Description Ensures that a select from a serializalbe transaction is ok after vacuum
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
1: BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
2: VACUUM ao;
1: SELECT COUNT(*) FROM ao;
3: INSERT INTO ao VALUES (0);
