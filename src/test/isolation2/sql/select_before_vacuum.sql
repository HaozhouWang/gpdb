-- @Description Ensures that a select before a vacuum operation is ok
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

DROP VIEW IF EXISTS locktest;
create view locktest as select coalesce(
	case when relname like 'pg_toast%index' then 'toast index'
	when relname like 'pg_toast%' then 'toast table'
	else relname end, 'dropped table'),
	mode,
	locktype from
	pg_locks l left outer join pg_class c on (l.relation = c.oid),
	pg_database d where relation is not null and l.database = d.oid and
	l.gp_segment_id = -1 and
	relname != 'gp_fault_strategy' and
	d.datname = current_database() order by 1, 3, 2;

DELETE FROM ao WHERE a < 128;
1: BEGIN;
1: SELECT COUNT(*) FROM ao;
1: SELECT * FROM locktest WHERE coalesce = 'ao';
2&: VACUUM ao;
1: COMMIT;
2<:
1: SELECT COUNT(*) FROM ao;
3: INSERT INTO ao VALUES (0);
