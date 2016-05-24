#!/bin/bash


for r in `seq 1 22`; do
    psql -f queries/$r.sql
done
