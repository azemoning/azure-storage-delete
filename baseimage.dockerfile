FROM ubuntu:16.04
RUN apt-get update && apt-get install -y wget rsync git zsh cron
RUN git clone https://github.com/azemoning/azure-storage-delete.git  /root/deletebackup 
WORKDIR /root/deletebackup
RUN wget -O azcopyv10.tar https://azcopyvnext.azureedge.net/release20190517/azcopy_linux_amd64_10.1.2.tar.gz \
    && tar -xf azcopyv10.tar --strip-components=1 \
    && ./azcopy
RUN mkdir backup_dir
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true 
RUN chmod +x *.sh && \
    cp deletecron /etc/cron.d/ && chmod 0644 /etc/cron.d/deletecron && \
    touch /var/log/deletecron
CMD ["zsh"]