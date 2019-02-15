https://medium.com/@jayden.chua/use-supervisor-to-run-your-python-tests-13e91171d6d3

## ======================================== ##
##             Docker Build (Host)
## ======================================== ##
for file in *; do
    sed $'s/[^[:print:]\t]//g' "$file" > "$file.temp"
    rm "$file"
    mv "$file.temp" "$file"
done

sudo docker build -t bigdataplot/job-monitor:1.61 .

sudo docker login --username bigdataplot
sudo docker push bigdataplot/job-monitor:1.61

## ======================================== ##
##               Build my own
## ======================================== ##


sudo docker run --name job-monitor \
    --detach \
    --restart always\
    --publish 9011:80 \
    --publish 9001:9001 \
    --volume /etc/localtime:/etc/localtime:ro \
    bigdataplot/job-monitor:1.61


sudo docker exec -it job-monitor bash

apt-get update

apt-get install -y nano supervisor git




!! if /apps/job-monitor is empty

mkdir -p /local/apps/
cd /local/apps/
git clone https://github.com/mlazarov/supervisord-monitor.git

cp -a /local/apps/supervisord-monitor/. /apps/job-monitor/

rm -rf /local/apps/supervisord-monitor/



cd /apps/job-monitor/

cp ./application/config/supervisor.php.example ./application/config/supervisor.php
cp /etc/supervisor/supervisord.conf ./application/config/supervisord.conf


# Multiple monitor UI
nano ./application/config/supervisor.php

'url' => 'http://server01.app/RPC2',
'url' => 'http://localhost/RPC2'


# Single Supervisord
!! no quote!!

export USR="yourusername"
export PSW="yourpass"

echo " " >> ./application/config/supervisord.conf
echo "[inet_http_server]" >> ./application/config/supervisord.conf
echo "port=*:9001" >> ./application/config/supervisord.conf
echo "username=${USR}" >> ./application/config/supervisord.conf
echo "password=${PSW}" >> ./application/config/supervisord.conf

nano ./application/config/supervisord.conf



!!

cd /local/apps/

supervisord -c ./application/config/supervisord.conf



php -S 0.0.0.0:80 -t ./public_html/





cd /supervisord-monitor/application/views/

rm welcome2.php
cp welcome.php welcome2.php

export SUPPORTEMAIL="cvtsupport@nrg.com"
sed -i 's|"mailto:martin@lazarov.bg"|"'${SUPPORTEMAIL}'"|g' welcome2.php

export SUPPORTTITL="CVT-Support-Center"
sed -i 's|"Support Center"|"'${SUPPORTTITL}'"|g' welcome2.php



php -S 0.0.0.0:80 -t supervisord-monitor/public_html/













apt-get install -y build-essential libpq-dev libssl-dev openssl libffi-dev zlib1g-dev && \
    apt-get install -y python3-pip python3-dev  && \
    python3 -m pip install --upgrade pip

rm /usr/bin/python3
ln -s /usr/bin/python3.5 /usr/bin/python3


apt-get upgrade

apt-get --purge autoremove -y




A simple safe way would be to use an alias. Place this into ~/.bashrc or ~/.bash_aliases file:

alias python=python3

After adding the above in the file, run source ~/.bashrc or source ~/.bash_aliases.





