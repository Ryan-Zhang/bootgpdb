-- create the database functions
CREATE OR REPLACE FUNCTION read_from_s3() RETURNS integer AS
        '$libdir/gps3ext.so', 's3_import' LANGUAGE C STABLE;

-- declare the protocol name along with in/out funcs
CREATE PROTOCOL s3 (
        readfunc  = read_from_s3
);

CREATE TABLE NATION  ( N_NATIONKEY  INTEGER NOT NULL,
                            N_NAME       CHAR(25) NOT NULL,
                            N_REGIONKEY  INTEGER NOT NULL,
                            N_COMMENT    VARCHAR(152));

CREATE TABLE REGION  ( R_REGIONKEY  INTEGER NOT NULL,
                            R_NAME       CHAR(25) NOT NULL,
                            R_COMMENT    VARCHAR(152));

CREATE TABLE PART  ( P_PARTKEY     INTEGER NOT NULL,
                          P_NAME        VARCHAR(55) NOT NULL,
                          P_MFGR        CHAR(25) NOT NULL,
                          P_BRAND       CHAR(10) NOT NULL,
                          P_TYPE        VARCHAR(25) NOT NULL,
                          P_SIZE        INTEGER NOT NULL,
                          P_CONTAINER   CHAR(10) NOT NULL,
                          P_RETAILPRICE DECIMAL(15,2) NOT NULL,
                          P_COMMENT     VARCHAR(23) NOT NULL );

CREATE TABLE SUPPLIER ( S_SUPPKEY     INTEGER NOT NULL,
                             S_NAME        CHAR(25) NOT NULL,
                             S_ADDRESS     VARCHAR(40) NOT NULL,
                             S_NATIONKEY   INTEGER NOT NULL,
                             S_PHONE       CHAR(15) NOT NULL,
                             S_ACCTBAL     DECIMAL(15,2) NOT NULL,
                             S_COMMENT     VARCHAR(101) NOT NULL);


CREATE TABLE PARTSUPP ( PS_PARTKEY     INTEGER NOT NULL,
                             PS_SUPPKEY     INTEGER NOT NULL,
                             PS_AVAILQTY    INTEGER NOT NULL,
                             PS_SUPPLYCOST  DECIMAL(15,2)  NOT NULL,
                             PS_COMMENT     VARCHAR(199) NOT NULL );

CREATE TABLE CUSTOMER ( C_CUSTKEY     INTEGER NOT NULL,
                             C_NAME        VARCHAR(25) NOT NULL,
                             C_ADDRESS     VARCHAR(40) NOT NULL,
                             C_NATIONKEY   INTEGER NOT NULL,
                             C_PHONE       CHAR(15) NOT NULL,
                             C_ACCTBAL     DECIMAL(15,2)   NOT NULL,
                             C_MKTSEGMENT  CHAR(10) NOT NULL,
                             C_COMMENT     VARCHAR(117) NOT NULL);

CREATE TABLE ORDERS  ( O_ORDERKEY       INTEGER NOT NULL,
                           O_CUSTKEY        INTEGER NOT NULL,
                           O_ORDERSTATUS    CHAR(1) NOT NULL,
                           O_TOTALPRICE     DECIMAL(15,2) NOT NULL,
                           O_ORDERDATE      DATE NOT NULL,
                           O_ORDERPRIORITY  CHAR(15) NOT NULL,
                           O_CLERK          CHAR(15) NOT NULL,
                           O_SHIPPRIORITY   INTEGER NOT NULL,
                           O_COMMENT        VARCHAR(79) NOT NULL);


CREATE TABLE LINEITEM ( L_ORDERKEY    INTEGER NOT NULL,
                             L_PARTKEY     INTEGER NOT NULL,
                             L_SUPPKEY     INTEGER NOT NULL,
                             L_LINENUMBER  INTEGER NOT NULL,
                             L_QUANTITY    DECIMAL(15,2) NOT NULL,
                             L_EXTENDEDPRICE  DECIMAL(15,2) NOT NULL,
                             L_DISCOUNT    DECIMAL(15,2) NOT NULL,
                             L_TAX         DECIMAL(15,2) NOT NULL,
                             L_RETURNFLAG  CHAR(1) NOT NULL,
                             L_LINESTATUS  CHAR(1) NOT NULL,
                             L_SHIPDATE    DATE NOT NULL,
                             L_COMMITDATE  DATE NOT NULL,
                             L_RECEIPTDATE DATE NOT NULL,
                             L_SHIPINSTRUCT CHAR(25) NOT NULL,
                             L_SHIPMODE     CHAR(10) NOT NULL,
                             L_COMMENT      VARCHAR(44) NOT NULL);

create external table ext_NATION ( like NATION ) location ('s3://s3-us-west-2.amazonaws.com/s3test.pivotal.io/data/nation.tbl config=/home/gpadmin/s3.conf') format 'TEXT' ( DELIMITER as '|' );

create external table ext_region ( like region ) location ('s3://s3-us-west-2.amazonaws.com/s3test.pivotal.io/data/region.tbl config=/home/gpadmin/s3.conf') format 'TEXT' ( DELIMITER as '|' );

create external table ext_partsupp ( like partsupp ) location ('s3://s3-us-west-2.amazonaws.com/s3test.pivotal.io/data/partsupp config=/home/gpadmin/s3.conf') format 'TEXT' ( DELIMITER as '|' );

create external table ext_customer ( like customer ) location ('s3://s3-us-west-2.amazonaws.com/s3test.pivotal.io/data/customer config=/home/gpadmin/s3.conf') format 'TEXT' ( DELIMITER as '|' );

create external table ext_lineitem ( like lineitem ) location ('s3://s3-us-west-2.amazonaws.com/s3test.pivotal.io/data/lineitem config=/home/gpadmin/s3.conf') format 'TEXT' ( DELIMITER as '|' );

create external table ext_orders ( like orders ) location ('s3://s3-us-west-2.amazonaws.com/s3test.pivotal.io/data/orders config=/home/gpadmin/s3.conf') format 'TEXT' ( DELIMITER as '|' );

create external table ext_part ( like part ) location ('s3://s3-us-west-2.amazonaws.com/s3test.pivotal.io/data/part/ config=/home/gpadmin/s3.conf') format 'TEXT' ( DELIMITER as '|' );

create external table ext_supplier ( like supplier ) location ('s3://s3-us-west-2.amazonaws.com/s3test.pivotal.io/data/supplier config=/home/gpadmin/s3.conf') format 'TEXT' ( DELIMITER as '|' );


insert into nation select * from ext_nation ;
insert into region select * from ext_region ;
insert into partsupp select * from ext_partsupp ;
insert into customer select * from ext_customer ;
insert into lineitem  select * from ext_lineitem ;
insert into orders select * from ext_orders ;
insert into part select * from ext_part ;
insert into supplier select * from ext_supplier ;
