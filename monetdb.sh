#!/bin/sh
DBFARM_PATH="/home/lsidir/srgab_dbfarm"
DBNAME="srgab"
monetdbd create $DBFARM_PATH
monetdbd start $DBFARM_PATH
monetdb create $DBNAME
monetdb release $DBNAME
monetdb start $DBNAME
