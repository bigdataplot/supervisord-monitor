#!/bin/bash
#start_monitor.sh

export JOBFOLDER=__STARTMONITORPATH__
supervisord -c ${JOBFOLDER}/application/config/supervisord.conf

sleep 3
php -S 0.0.0.0:9011 -t ${JOBFOLDER}/public_html/
