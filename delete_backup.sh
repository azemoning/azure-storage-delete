#!/bin/zsh
export $(cat /root/deletebackup/env.env | xargs)
DIR_NAME=`date -d "-5 day" +%Y-%d-%m`

## Kill old cpulimit process before starting new cpulimit process
pkill cpulimit

## Start cpulimit process
cpulimit -P /root/deletebackup/azcopy -l 20 -b

echo -e "Syncing from azure storage."
/root/deletebackup/azcopy sync $BLOB_SAS "/root/deletebackup/backup_dir" --recursive 
echo -e "Synchronizing sucessful."
if [ -d "$DIR_NAME" ]; then
    ## Pinging healthchecks to inform that deleting blob will be started.
    curl -fsS --retry 3 https://hc-ping.com/05e5688a-8e46-4357-a11b-740f6d54f4fe > /dev/null
    ## Starting delete.
    rm /root/deletebackup/backup_dir/$DIR_NAME/*(Om[1, -24])
    echo -e "Delete sucessful."
    echo -e "Start synchronizing to azure blob storage"
    ./azcopy sync "/root/deletebackup/backup_dir" $BLOB_SAS --recursive --delete-destination=true
    echo -e "Synchronizing finished, exiting."
    else
    echo -e "No 5 days old directory, exiting."
fi
## Pinging healthchecks to inform that deleting local blob file will be started.
curl -fsS --retry 3 https://hc-ping.com/0bf7e2ae-1cfe-4af5-8ea5-5edeb56ee5b9 > /dev/null
## Starting delete.
if ! rm -rf /root/deletebackup/backup_dir/*; then
    echo -e "No any local backup files exist, exiting."
    else
        echo -e "Deleting local backup files."
        echo -e "Deleting local backup files sucessful, Exiting."
fi