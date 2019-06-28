#!/bin/zsh
DIR_NAME=`date -d "-5 day" +%Y-%d-%m`

echo -e "Syncing from azure storage."
./azcopy sync "https://telinmystore.blob.core.windows.net/pg-back-rest-testing?st=2019-06-27T02%3A31%3A00Z&se=2019-06-28T02%3A31%3A00Z&sp=racwdl&sv=2018-03-28&sr=c&sig=Dyn6MW%2FN9TdEGj4FCoH172YK87TYaQlwFWR%2Bdmvpl40%3D" \
              "/root/deletebackup/backup_dir" --recursive 
echo -e "Synchronizing sucessful."
if [ -d "$DIR_NAME" ]; then
    rm /root/deletebackup/backup_dir/$DIR_NAME/*(Om[1, -24])
    echo -e "Delete sucessful."
    echo -e "Start synchronizing to azure blob storage"
    ./azcopy sync "/root/deletebackup/backup_dir" "https://telinmystore.blob.core.windows.net/pg-back-rest-testing?st=2019-06-27T02%3A31%3A00Z&se=2019-06-28T02%3A31%3A00Z&sp=racwdl&sv=2018-03-28&sr=c&sig=Dyn6MW%2FN9TdEGj4FCoH172YK87TYaQlwFWR%2Bdmvpl40%3D"
    echo -e "Synchronizing finished, exiting."
    else
    echo -e "No 5 days old directory, exiting."
fi