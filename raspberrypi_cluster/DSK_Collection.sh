
#!/bin/bash

#Collects disk data on all nodes and adds it to a log file

Collection()
{
        printf "\n.$1 \n" >> ~/logs/DSK_Collection.log
        ssh pi@172.168.0.$1 "df -h" >> ~/logs/DSK_Collection.log && printf "\n" >> ~/logs/DSK_Collection.log
        ssh pi@172.168.0.$1 "lsblk" >> ~/logs/DSK_Collection.log && printf "\n" >> ~/logs/DSK_Collection.log
}

if [[ $(date +%u) -gt 6 ]];
then
        dt_code=$(date +%m-%d)
        date +%m-%d-%j >> ~/logs/DSK_Collection.log
        Collection 53 && Collection 54 && Collection 55 && Collection 56
        mv ~/logs/DSK_Collection.log ~/logs/backlogs/DSK/$dt_code-DSK.backlog
        date +%m-%d-%j >> ~/logs/DSK_Collection.log
        Collection 53 && Collection 54 && Collection 55 && Collection 56
else
        date +%m-%d-%j >> ~/logs/DSK_Collection.log
        Collection 53 && Collection 54 && Collection 55 && Collection 56
fi
