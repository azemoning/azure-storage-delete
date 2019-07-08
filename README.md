# azure-storage-delete
Azure storage delete automation with cron

## Usage

### Deploy
```dockerfile
FROM azemoning/azure-storage-delete:latest
SHELL ["/bin/zsh","-c"]
## BLOB_SAS='"url"'
ENV BLOB_SAS=
RUN setopt rm_star_silent
RUN env > env.env
CMD cron && tail -f /var/log/deletecron.log
```

## Configuring cron schedule

To configure cron schedule, please refer to the official cron formatting.\
**Do not remove the empty line at the end of the cron file. It is required to run the cron job.**\
If there is no empty line at the file, please add by yourself.
