DROP TABLE IF EXISTS pt_lt_tab;
CREATE TABLE pt_lt_tab
(
  col1 int,
  col2 decimal,
  col3  text,
  col4 bool
  
)
distributed by (col1)
partition by list(col2)
(
	partition part1 values(1,2,3,4,5,6,7,8,9,10),
	partition part2 values(11,12,13,14,15,16,17,18,19,20),
	partition part3 values(21,22,23,24,25,26,27,28,29,30),
	partition part4 values(31,32,33,34,35,36,37,38,39,40),
	partition part5 values(41,42,43,44,45,46,47,48,49,50)
);

INSERT INTO pt_lt_tab SELECT i, i,'a',True FROM generate_series(1,3)i;
INSERT INTO pt_lt_tab SELECT i, i,'b',True FROM generate_series(4,6)i;
INSERT INTO pt_lt_tab SELECT i, i,'c',True FROM generate_series(7,10)i;

INSERT INTO pt_lt_tab SELECT i, i,'e',True FROM generate_series(11,13)i;
INSERT INTO pt_lt_tab SELECT i, i,'f',True FROM generate_series(14,16)i;
INSERT INTO pt_lt_tab SELECT i, i,'g',True FROM generate_series(17,20)i;

INSERT INTO pt_lt_tab SELECT i, i,'i',False FROM generate_series(21,23)i;
INSERT INTO pt_lt_tab SELECT i, i,'k',False FROM generate_series(24,26)i;
INSERT INTO pt_lt_tab SELECT i, i,'h',False FROM generate_series(27,30)i;

INSERT INTO pt_lt_tab SELECT i, i,'m',False FROM generate_series(31,33)i;
INSERT INTO pt_lt_tab SELECT i, i,'o',False FROM generate_series(34,36)i;
INSERT INTO pt_lt_tab SELECT i, i,'n',False FROM generate_series(37,40)i;

INSERT INTO pt_lt_tab SELECT i, i,'p',False FROM generate_series(41,43)i;
INSERT INTO pt_lt_tab SELECT i, i,'s',False FROM generate_series(44,46)i;
INSERT INTO pt_lt_tab SELECT i, i,'q',False FROM generate_series(47,50)i;
ANALYZE pt_lt_tab;
