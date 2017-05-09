#!/bin/bash

set -ex
# dbgen command

SCALE=1
SPLIT=16

function mv2s3_old {
	sed 's/|$//' "$1" | gzip | gof3r put -b s3test.pivotal.io  -k "verify/tpchdata1g/$1.gz" --endpoint s3-us-west-2.amazonaws.com
	rm -f "$1"
} 

function mv2s3 {
	sed 's/|$//' "$1" | gzip | s3cmd put - "s3://s3test.pivotal.io/verify/tpchdata1g/$1.gz" 
	rm -f "$1"
}

function up2s3 {
	ls -lh $1
} 

# create region.tbl and nation.tbl
./dbgen -T l -f -s ${SCALE}

mv2s3 nation.tbl
mv2s3 region.tbl

# create cutomer.tbl
TABLENAME=customer.tbl
for i in `seq 1 ${SPLIT}`
    do
       echo "Generateing ${TABLENAME}.$i"
       ./dbgen -T c -f -s ${SCALE} -C ${SPLIT} -S ${i}
       mv2s3 ${TABLENAME}.$i
done

# create lineitem.tbl
TABLENAME=lineitem.tbl
for i in `seq 1 ${SPLIT}`
    do
       echo "Generateing ${TABLENAME}.$i"
       ./dbgen -T L -f -s ${SCALE} -C ${SPLIT} -S ${i}
       mv2s3 ${TABLENAME}.$i
done

# create orders.tbl
TABLENAME=orders.tbl
for i in `seq 1 ${SPLIT}`
    do
       echo "Generateing ${TABLENAME}.$i"
       ./dbgen -T O -f -s ${SCALE} -C ${SPLIT} -S ${i}
       mv2s3 ${TABLENAME}.$i
done

# create part.tbl
TABLENAME=part.tbl
for i in `seq 1 ${SPLIT}`
    do
       echo "Generateing ${TABLENAME}.$i"
       ./dbgen -T P -f -s ${SCALE} -C ${SPLIT} -S ${i}
       mv2s3 ${TABLENAME}.$i
done

# create supplier.tbl
TABLENAME=supplier.tbl
for i in `seq 1 ${SPLIT}`
    do
       echo "Generateing ${TABLENAME}.$i"
       ./dbgen -T s -f -s ${SCALE} -C ${SPLIT} -S ${i}
       mv2s3 ${TABLENAME}.$i
done

# create partsupp.tbl
TABLENAME=partsupp.tbl
for i in `seq 1 ${SPLIT}`
    do
       echo "Generateing ${TABLENAME}.$i"
       ./dbgen -T S -f -s ${SCALE} -C ${SPLIT} -S ${i}
       mv2s3 ${TABLENAME}.$i
done

