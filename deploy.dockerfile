FROM azemoning/azure-storage-delete:latest
ENV BLOB_SAS=
RUN setopt rm_star_silent
RUN env > env.env
CMD cron && tail -f /var/log/deletecron.log