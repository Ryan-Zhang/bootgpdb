DROP TABLE if exists widetable;
CREATE TABLE widetable (
	   col1 bigint,
	   col2 bigserial,
	   col3 bit(15),
	   col4 varbit(15),
	   col5 bool,
	   col6 box,
	   col7 bytea,
	   col8 char(7),
	   col9 varchar(7),
	   col10 cidr,
	   col11 circle,
	   col12 date,
	   col13 decimal(8,2),
	   col14 float,
	   col15 inet,
	   col16 int,
	   col17 interval(5),
	   col18 json,
	   col19 lseg,
	   col20 macaddr,
	   col21 money,
	   col22 path,
	   col23 point,
	   col24 polygon,
	   col25 real,
	   col26 serial,
	   col27 smallint,
	   col28 text,
	   col29 time,
	   col30 timetz,
	   col31 timestamp,
	   col32 timestamptz,
	   col33 uuid,
	   col34 xml
	   );


drop external table if exists widetable_ext;
-- drop external table if exists widetable_s3;

create external table widetable_ext ( like lineitem ) location ('gpfdist://mdw:8080/widetable.txt') format 'TEXT' ( DELIMITER as '|' );
-- create external table widetable_s3 ( like lineitem ) location ('s3://s3-us-west-2.amazonaws.com/s3test.pivotal.io/data/lineitem config=/home/gpadmin/s3.conf') format 'TEXT' ( DELIMITER as '|' );
