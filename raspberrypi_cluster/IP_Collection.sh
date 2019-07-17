#!/bin/bash

#This Script is assuming you are using a 4 node cluster with an ip range of 192.168.0.53 - .56 /24
#If you decide to use this for whatever reason make sure all nodes have each others keys so no password iss needed

Collection()
{
        date +%m-%d-%j >> ~/log/IP_collection.log
        printf "\nIP: 53/24\n" >> ~/logs/IP_collection.log
        ssh pi@192.168.0.53 "curl http://ipinfo.io" >> ~/logs/IP_collection.log
        printf "\nIP: 54/24\n" >> ~/logs/IP_collection.log
        ssh pi@192.168.0.54 "curl http://ipinfo.io" >> ~/logs/IP_collection.log
        printf "\nIP: 55/24\n" >> ~/logs/IP_collection.log
        ssh pi@192.168.0.55 "curl http://ipinfo.io" >> ~/logs/IP_collection.log
        printf "\nIP: 56/24\n" >> ~/logs/IP_collection.log
        curl http://ipinfo.io >> ~/logs/IP_collection.log
}

if [[ $(date +%u) -gt 6 ]];
then
        Collection
        dt_code=$(date +%m-%d)
        mv  ~/logs/IP_collection.log ~/log/backlogs/IP/$dt_code-IP.backlog
        Collection
else
        Collection
fi
