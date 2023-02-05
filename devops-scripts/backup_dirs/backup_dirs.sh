#!/bin/bash

SELF_DIR=`dirname -- "$0"`;
cd $SELF_DIR;

###DIRS for backup
declare -a BACKUP_DIRS=('/fs/it/dss' '/fs/it/gate' '/fs/it/gp-uzdo' '/fs/it/lbedb');
###

NOW_DATE=`/bin/date '+%Y%m%d%H%M%S'`;
/bin/mkdir -p "$SELF_DIR/$NOW_DATE";
DIR_FOR_COPY="$SELF_DIR/$NOW_DATE";

for DIR in "${BACKUP_DIRS[@]}"
do
    /bin/cp -r $DIR "$DIR_FOR_COPY/";
done;

EXE_RES=`/usr/bin/zip -rm9 "$NOW_DATE.zip" $NOW_DATE`;
