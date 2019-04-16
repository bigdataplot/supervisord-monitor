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
ENV APPFOLDER "/local/apps"
ENV JOBFOLDER ${APPFOLDER}/job-monitor
ENV USR "yourusername"
ENV PSW "yourpass"


## Clone from Git
RUN mkdir -p ${JOBFOLDER}

WORKDIR ${APPFOLDER}
RUN git clone https://github.com/bigdataplot/supervisord-monitor.git

RUN cp -a ${APPFOLDER}/supervisord-monitor/. ${JOBFOLDER}/
RUN rm -rf ${APPFOLDER}/supervisord-monitor/


## Change App Directory
WORKDIR ${JOBFOLDER}


# Multiple monitor UI
RUN cp ./application/config/supervisor.php.example ./application/config/supervisor.php


# Single Supervisord
RUN cp /etc/supervisor/supervisord.conf ./application/config/supervisord.conf

RUN echo " " >> ./application/config/supervisord.conf
RUN echo "[inet_http_server]" >> ./application/config/supervisord.conf
RUN echo "port=*:9001" >> ./application/config/supervisord.conf


## Customize Welcome Page
RUN echo "username=${USR}" >> ./application/config/supervisord.conf
RUN echo "password=${PSW}" >> ./application/config/supervisord.conf


## File Transfer / Fix Permission
COPY start_monitor.sh start_monitor.sh
RUN sed -i "s|__STARTMONITORPATH__|${JOBFOLDER}|g" start_monitor.sh
RUN chmod 511 start_monitor.sh


## Create Test Process
RUN mkdir -p /jobs/log
RUN mkdir -p /jobs/error
COPY py_test.py /jobs/py_test.py
COPY py_test.conf /etc/supervisor/conf.d/py_test.conf
RUN touch /jobs/log/py_test.log
RUN touch /jobs/error/py_test_err.log


## Cleaning
RUN apt-get --purge autoremove -y && \
    apt-get clean -y


## Environment Configuration
EXPOSE 9011


## Run
CMD bash ${JOBFOLDER}/start_monitor.sh

## ========== End-Of-Dockerfile ==========
