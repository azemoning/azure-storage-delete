#!/bin/zsh
export $(cat /root/deletebackup/env.env | xargs)
DIR_NAME=`date -d "-5 day" +%Y-%d-%m`

echo -e "Syncing from azure storage."
/root/deletebackup/azcopy sync $BLOB_SAS "/root/deletebackup/backup_dir" --recursive 
echo -e "Synchronizing sucessful."
if [ -d "$DIR_NAME" ]; then
    rm /root/deletebackup/backup_dir/$DIR_NAME/*(Om[1, -24])
    echo -e "Delete sucessful."
    echo -e "Start synchronizing to azure blob storage"
    ./azcopy sync "/root/deletebackup/backup_dir" $BLOB_SAS
    echo -e "Synchronizing finished, exiting."
    else
    echo -e "No 5 days old directory, exiting."
fi
echo -e "Deleting local backup files."
rm -rf /root/deletebackup/backup_dir/*
echo -e "Deleting local backup files sucessful."