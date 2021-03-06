--
-- TEXT
--

SELECT text 'this is a text string' = text 'this is a text string' AS true;

SELECT text 'this is a text string' = text 'this is a text strin' AS false;

CREATE TABLE TEXT_TBL (f1 text);

INSERT INTO TEXT_TBL VALUES ('doh!');
INSERT INTO TEXT_TBL VALUES ('hi de ho neighbor');

SELECT '' AS two, * FROM TEXT_TBL order by f1;

-- As of 8.3 we have removed most implicit casts to text, so that for example
-- this no longer works:

select length(42);

-- But as a special exception for usability's sake, we still allow implicit
-- casting to text in concatenations, so long as the other input is text or
-- an unknown literal.  So these work:

select 'four: '::text || 2+2;
select 'four: ' || 2+2;

-- but not this:

select 3 || 4.0;

--
-- TEXT CASTING TO/FROM ANY TYPE
--
SELECT '1'::bool::text;
SELECT array[1,2]::text;
SELECT '{1,2}'::text::integer[];

CREATE TYPE usr_define_type as (id int, name text);
SELECT '(1,abc)'::text::usr_define_type;
