# azure-storage-delete
Azure storage delete automation with cron

## Usage

### Prerequisite

Before configuring or deploying image, you need to create an account at [Healthchecks.io](https://healthcheks.io). Create new project and add check on that project.\
After adding a new check, copy **Ping URL** and replace the url at the curl command on [delete_backup.sh](https://github.com/azemoning/azure-storage-delete/blob/master/delete_backup.sh).

Example:

```bash

curl -fsS --retry 3 https://hc-ping.com/replace_this_with_your_own_url > /dev/null


```

After that, you can rebuild the image and then deploy it on your own project.

```bash

docker build -t azure-storage-delete .

```

### Deploy

```dockerfile

FROM azure-storage-delete:latest ## Or with your own custom image name
SHELL ["/bin/zsh","-c"]
## BLOB_SAS='"url"'
ENV BLOB_SAS=
## DB_COUNT=24 #total database on your postgresql. 
## E.g, if you have 10 databases then set to 13 (with azure_maintenance, azure_sys, & postgres)
ENV DB_COUNT=
RUN setopt rm_star_silent
RUN env > env.env
CMD cron && tail -f /var/log/deletecron.log

```

## Configuring cron schedule

To configure cron schedule, please refer to the official cron formatting.\
**Do not remove the empty line at the end of the cron file. It is required to run the cron job.**\
If there is no empty line at the file, please add by yourself.
