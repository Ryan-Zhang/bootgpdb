#!/bin/bash


killall -9 postgres

rm -f /tmp/.s.PGSQL.*
rm -rf data/* master/* mirror/*
