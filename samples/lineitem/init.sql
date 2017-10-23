DROP TABLE if exists LINEITEM;
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


drop external table if exists lineitem_ext;
drop external table if exists lineitem_s3;

create external table lineitem_ext ( like lineitem ) location ('gpfdist://mdw:8080/lineitem.txt') format 'TEXT' ( DELIMITER as '|' );
create external table lineitem_s3 ( like lineitem ) location ('s3://s3-us-west-2.amazonaws.com/s3test.pivotal.io/data/lineitem config=/home/gpadmin/s3.conf') format 'TEXT' ( DELIMITER as '|' );
