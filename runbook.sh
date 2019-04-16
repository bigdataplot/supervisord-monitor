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

sudo docker build -t bigdataplot/job-monitor:2.02 .

sudo docker login --username bigdataplot
sudo docker push bigdataplot/job-monitor:2.02


## ======================================== ##
##                  Run
## ======================================== ##


sudo docker run --detach \
    --name job-monitor \
    --hostname job-monitor \
    --restart always\
    --network host \
    --env TERM=xterm \
    --volume /etc/localtime:/etc/localtime:ro \
    bigdataplot/job-monitor:2.02


sudo docker run --detach \
    --name job-monitor \
    --hostname job-monitor \
    --restart always\
    --publish 9011:9011 \
    --publish 9001:9001 \
    --env TERM=xterm \
    --volume /etc/localtime:/etc/localtime:ro \
    bigdataplot/job-monitor:2.02




sudo docker exec -it job-monitor bash

## Customize support email and Welcome page title

sed -i "s|__support_email__|your@email.com|g" ./application/views/welcome.php
sed -i "s|__support_name__|Your Job Center|g" ./application/views/welcome.php

sed -i "s|__support_email__|ken.oyang@gmail.com|g" ./application/views/welcome.php
sed -i "s|__support_name__|BigDataPlot Job Center|g" ./application/views/welcome.php

## ======================================== ##
#  Web Front Page:
nano /local/apps/job-monitor/application/config/supervisor.php

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


=======================
# On ks-db
# Auto run autossh

• Copy id_rsa to /root/.ssh/ folder and make sure it has the proper permission set
• Create a service bash script on: cd /etc/systemd/system:
sudo su

Test:
/usr/bin/autossh -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -v -NR 19011:localhost:9011 youyang@104.42.171.155 -p 22 -i /root/.ssh/RSH-id_rsa


Add file:
nano /etc/systemd/system/bdpjob.service

------------------------------------
[Unit]
Description=BigDataPlot Boot-up Service
After=network.target

[Service]
Environment="AUTOSSH_GATETIME=0"
ExecStart=/usr/bin/autossh -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -v -NR 19011:localhost:9011 youyang@104.42.171.155 -p 22 -i /root/.ssh/RSH-id_rsa

[Install]
WantedBy=multi-user.target
------------------------------------

• Apply the new service using:
systemctl start bdpjob
systemctl enable bdpjob
systemctl stop bdpjob
systemctl disable bdpjob
systemctl status bdpjob
