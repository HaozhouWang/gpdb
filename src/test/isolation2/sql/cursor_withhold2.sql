-- @Description Tests the visibility of an "with hold" cursor w.r.t. deletes.
-- 
DROP TABLE IF EXISTS ao;
CREATE TABLE ao (a INT) WITH (appendonly=true);
insert into ao select generate_series(1,10);

1: BEGIN;
1: DECLARE cur CURSOR WITH HOLD FOR SELECT a FROM ao ORDER BY a;
1: FETCH NEXT IN cur;
1: FETCH NEXT IN cur;
1: COMMIT;
2: BEGIN;
2: DELETE FROM ao WHERE a < 5;
2: COMMIT;
3: VACUUM ao;
1: FETCH NEXT IN cur;
1: FETCH NEXT IN cur;
1: FETCH NEXT IN cur;
1: CLOSE cur;
3: DECLARE cur CURSOR WITH HOLD FOR SELECT a FROM ao ORDER BY a;
3: FETCH NEXT IN cur;
3: CLOSE cur;
