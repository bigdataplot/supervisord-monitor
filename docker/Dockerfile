#  Copyright (c) bigdataplot LLC
#  Distributed Under GNU GENERAL PUBLIC LICENSE

## ========== Begin-Of-Dockerfile ==========
## Build Base
FROM php:7


## Base Update
RUN umask 022
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git nano supervisor ssh-client


## Tag
MAINTAINER Yongjian(Ken) Ouyang <yongjian.ouyang@outlook.com>


## Environment Settings
ENV JOBFOLDER "/apps/job-monitor"


## Clone from Git
RUN mkdir -p /local/apps/

WORKDIR /local/apps/
RUN git clone https://github.com/bigdataplot/supervisord-monitor.git

RUN cp -a /local/apps/supervisord-monitor/. ${JOBFOLDER}/
RUN rm -rf /local/apps/supervisord-monitor/


## Create/Change App Directory
WORKDIR ${JOBFOLDER}


# Multiple monitor UI
RUN cp ./application/config/supervisor.php.example ./application/config/supervisor.php


# Single Supervisord
RUN cp /etc/supervisor/supervisord.conf ./application/config/supervisord.conf

RUN echo " " >> ./application/config/supervisord.conf
RUN echo "[inet_http_server]" >> ./application/config/supervisord.conf
RUN echo "port=*:9001" >> ./application/config/supervisord.conf
RUN echo "username=${USR}" >> ./application/config/supervisord.conf
RUN echo "password=${PSW}" >> ./application/config/supervisord.conf


## File Transfer / Fix Permission
COPY start_monitor.sh start_monitor.sh
RUN sed -i "s|start_monitor_location|${JOBFOLDER}|g" start_monitor.sh
RUN chmod 511 start_monitor.sh


## Cleaning
RUN apt-get --purge autoremove -y && \
    apt-get clean -y


## Environment Configuration
EXPOSE 80


## Run
CMD bash ${JOBFOLDER}/start_monitor.sh

## ========== End-Of-Dockerfile ==========