-- start_ignore
SET gp_create_table_random_default_distribution=off;
-- end_ignore
-- start_ignore
DROP TABLE if exists sto_alt_ao1;
-- end_ignore

CREATE TABLE sto_alt_ao1(
          text_col text default 'remove it',
          bigint_col bigint,
          char_vary_col character varying(30),
          numeric_col numeric,
          int_col int4 NOT NULL,
          float_col float4,
          int_array_col int[],
          before_rename_col int4,
          change_datatype_col numeric,
          a_ts_without timestamp without time zone,
          b_ts_with timestamp with time zone,
          date_column date,
          col_set_default numeric) with(appendonly=true) DISTRIBUTED RANDOMLY;

insert into sto_alt_ao1 values ('0_zero', 0, '0_zero', 0, 0, 0, '{0}', 0, 0, '2004-10-19 10:23:54', '2004-10-19 10:23:54+02', '1-1-2000',0);
insert into sto_alt_ao1 values ('1_zero', 1, '1_zero', 1, 1, 1, '{1}', 1, 1, '2005-10-19 10:23:54', '2005-10-19 10:23:54+02', '1-1-2001',1);
insert into sto_alt_ao1 values ('2_zero', 2, '2_zero', 2, 2, 2, '{2}', 2, 2, '2006-10-19 10:23:54', '2006-10-19 10:23:54+02', '1-1-2002',2);

select * from sto_alt_ao1 order by bigint_col;

-- start_ignore
Drop table if exists sto_alt_ao3;
-- end_ignore

Create table sto_alt_ao3 with(appendonly=true) as select * from sto_alt_ao1;

-- Alter table add column
Alter Table sto_alt_ao1  ADD COLUMN added_col character varying(30) default 'default';
insert into sto_alt_ao1 values ('3_zero', 3, '3_zero', 3, 3, 3, '{3}', 3, 3, '2004-10-19 10:23:54', '2004-10-19 10:23:54+02', '1-1-2000',3, 'newcol');
select * from sto_alt_ao1 order by bigint_col;

-- Alter table Drop column
Alter table sto_alt_ao1 Drop column float_col;
insert into sto_alt_ao1 values ('4_zero', 4, '4_zero', 4, 4, '{4}', 4, 4, '2004-10-19 10:23:54', '2004-10-19 10:23:54+02', '1-1-2000',4, 'newcol');
select * from sto_alt_ao1 order by bigint_col;

-- Alter table rename column
Alter Table sto_alt_ao1 RENAME COLUMN before_rename_col TO after_rename_col;
select * from sto_alt_ao1 order by bigint_col;

-- Alter table column type
Alter Table sto_alt_ao1 ALTER COLUMN change_datatype_col TYPE int4;
insert into sto_alt_ao1 values ('5_zero', 5, '5_zero', 5, 5, '{5}', 5, 5, '2004-10-19 10:23:54', '2004-10-19 10:23:54+02', '1-1-2000',5, 'newcol');
select * from sto_alt_ao1 order by bigint_col;

-- Alter column set default expression
Alter Table sto_alt_ao1 ALTER COLUMN col_set_default SET DEFAULT 0;
select * from sto_alt_ao1 order by bigint_col;

-- Alter column Drop default
Alter table sto_alt_ao1  alter column text_col drop default;
select * from sto_alt_ao1 order by bigint_col;

-- Alter column drop NOT NULL
Alter Table sto_alt_ao1 ALTER COLUMN int_col DROP NOT NULL;
select * from sto_alt_ao1 order by bigint_col;

-- Alter column set NOT NULL
Alter Table sto_alt_ao1 ALTER COLUMN int_col SET NOT NULL;
select * from sto_alt_ao1 order by bigint_col;

-- Alter table SET STORAGE
Alter Table sto_alt_ao1 ALTER char_vary_col SET STORAGE PLAIN;
insert into sto_alt_ao1 values ('6_zero', 6, '6_zero', 6, 6, '{6}', 6, 6, '2004-10-19 10:23:54', '2004-10-19 10:23:54+02', '1-1-2000',6, 'newcol');
select * from sto_alt_ao1 order by bigint_col;


-- Alter table inherit tables
-- start_ignore
Drop table if exists sto_ao_parent cascade;
-- end_ignore
CREATE TABLE sto_ao_parent (
  text_col text,
  bigint_col bigint,
  char_vary_col character varying(30),
  numeric_col numeric
  ) with(appendonly=true) DISTRIBUTED RANDOMLY;

insert into sto_ao_parent values ('0_zero', 0, '0_zero', 0);

-- start_ignore
Drop table if exists sto_alt_ao2;
-- end_ignore

CREATE TABLE sto_alt_ao2(
  text_col text,
  bigint_col bigint,
  char_vary_col character varying(30),
  numeric_col numeric
  ) with(appendonly=true) DISTRIBUTED RANDOMLY;
insert into sto_alt_ao2 values ('1_zero', 1, '1_zero', 1);

-- Alter table inherit parent table
ALTER TABLE sto_alt_ao2 INHERIT sto_ao_parent;
select * from sto_alt_ao2 order by bigint_col;

-- Alter table set distributed byt to a new column
Alter Table sto_alt_ao2 SET distributed by(text_col);
insert into sto_alt_ao2 values ('2_zero', 2, '2_zero', 2);
select * from sto_alt_ao2 order by bigint_col;

--Alter table set distributed randomly
Alter Table sto_alt_ao2 SET distributed randomly;
insert into sto_alt_ao2 values ('3_zero', 3, '3_zero', 3);
select * from sto_alt_ao2 order by bigint_col;

-- Alter table set Reorganize to true 
Alter Table sto_alt_ao2 SET WITH (reorganize=true);
insert into sto_alt_ao2 values ('4_zero', 4, '4_zero', 4);
select * from sto_alt_ao2 order by bigint_col;

-- Alter table set Reorganize to false 
Alter Table sto_alt_ao2 SET WITH (reorganize=false);
insert into sto_alt_ao2 values ('5_zero', 5, '5_zero', 5);
select * from sto_alt_ao2 order by bigint_col;

-- Alter table add table constraint
ALTER TABLE sto_alt_ao2  ADD CONSTRAINT lenchk CHECK (char_length(char_vary_col) < 10);
insert into sto_alt_ao2 values ('6_zero', 6, '6_zero', 6);
select * from sto_alt_ao2 order by bigint_col;

-- Alter table drop constriant
Alter table sto_alt_ao2  Drop constraint lenchk;
insert into sto_alt_ao2 values ('7_zero', 7, '7_zero', 7);
select * from sto_alt_ao2 order by bigint_col;

-- Alter column  set statistics
Alter table sto_alt_ao3  alter column before_rename_col set statistics 3;
select * from sto_alt_ao3 order by bigint_col;

--Alter table SET without OIDs
Alter table sto_alt_ao3 SET without oids;
select * from sto_alt_ao3 order by bigint_col;

--Alter table to a new owner
-- start_ignore
Drop table if exists sto_alt_ao4;
Drop role if exists ao_user1;
-- end_ignore
Create role ao_user1;
Create table sto_alt_ao4 with(appendonly=true) as select * from sto_alt_ao3;
Alter Table sto_alt_ao4  Owner to ao_user1;
select * from sto_alt_ao4 order by bigint_col;
