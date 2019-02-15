#!/bin/bash
#start_monitor.sh

export JOBFOLDER=start_monitor_location
supervisord -c ${JOBFOLDER}/application/config/supervisord.conf
sleep 5
php -S 0.0.0.0:80 -t ${JOBFOLDER}/public_html/