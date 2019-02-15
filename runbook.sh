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
    --env SUPPORTEMAIL="support@email.com" \
    --env SUPPORTNAME="Job Center" \
    --env TERM=xterm \
    --volume /etc/localtime:/etc/localtime:ro \
    bigdataplot/job-monitor:2.01



sudo docker run --name job-monitor \
    -it \
    --publish 9011:80 \
    --publish 9001:9001 \
    --env SUPPORTEMAIL="support@email.com" \
    --env SUPPORTNAME="Job Center" \
    --env TERM=xterm \
    --volume /etc/localtime:/etc/localtime:ro \
    bigdataplot/job-monitor:2.01 bash

