FROM ubuntu:16.04
RUN apt-get update && apt-get install -y wget rsync git zsh cron
WORKDIR /root/
RUN mkdir /root/backup
RUN wget -O azcopyv10.tar https://azcopyvnext.azureedge.net/release20190517/azcopy_linux_amd64_10.1.2.tar.gz \
    && tar -xf azcopyv10.tar --strip-components=1 \
    && ./azcopy
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true 
CMD zsh && cron