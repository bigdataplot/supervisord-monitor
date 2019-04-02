##
# > https://medium.com/@jayden.chua/use-supervisor-to-run-your-python-tests-13e91171d6d3

## ======================================== ##
##             Docker Build (Host)
## ======================================== ##
for file in *; do
    sed $'s/[^[:print:]\t]//g' "$file" > "$file.temp"
    rm "$file"
    mv "$file.temp" "$file"
done

sudo docker build -t bigdataplot/job-monitor:2.01 .

sudo docker login --username bigdataplot
sudo docker push bigdataplot/job-monitor:2.01


## ======================================== ##
##                  Run
## ======================================== ##

sudo docker run --name job-monitor \
    --detach \
    --restart always\
    --publish 9011:80 \
    --publish 9001:9001 \
    --env TERM=xterm \
    --volume /etc/localtime:/etc/localtime:ro \
    bigdataplot/job-monitor:2.01


sudo docker exec -it job-monitor bash

## Customize support email and Welcome page title

sed -i "s|__support_email__|your@email.com|g" ./application/views/welcome.php
sed -i "s|__support_name__|Your Job Center|g" ./application/views/welcome.php


## ======================================== ##
#  Configure URL :
nano  application/config/config.php

#  Base Site URL
$config['base_url']     = '/job-monitor';
#  Reverse Proxy IPs
$config['proxy_ips'] = '127.0.0.1';

#  Nginx:
    # Jobs Monitor Web Page:
    location /job-monitor {
        proxy_pass          http://127.0.0.1:9011/;
        proxy_set_header    Host            $host;
        proxy_set_header    X-Real-IP       $remote_addr;
        proxy_set_header    X-Forwarded-for $remote_addr;
        port_in_redirect    off;
        proxy_redirect      default;
        proxy_connect_timeout 86400;
    }

