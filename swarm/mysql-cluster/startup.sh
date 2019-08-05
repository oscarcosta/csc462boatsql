#!/bin/bash

# Hack: http://haishibai.blogspot.com/2017/11/setting-up-high-available-mysql.html
if [ "$1" = 'ndb_mgmd' ]; then

    NDB1=""
    NDB2=""
    MYSQL=""

    while [[ "$NDB1" == "" ]] || [[ "$NDB2" == "" ]] || [[ "$MYSQL" == "" ]]
    do
        NDB1=`curl -sL http://gatekeeper:8180/ndb1`
        NDB2=`curl -sL http://gatekeeper:8180/ndb2`
        MYSQL=`curl -sL http://gatekeeper:8180/mysql`
        if [ "$NDB1" == "Bad Request" ]; then NDB1=""; fi
        if [ "$DNB2" == "Bad Request" ]; then NDB2=""; fi
        if [ "$MYSQL" == "Bad Request" ]; then MYSQL=""; fi
        sleep 1
        echo "Waiting..."
    done

    #ndb_mgmd -f /usr/mysql-cluster/config.ini
    $@

    echo "Sending Ready Signal"

    curl -sX PUT http://gatekeeper:8180/management/READY

    while true; do sleep 1000; done

elif [ "$1" = 'ndbd' ]; then

    echo "Sending Launched Signal"

    LAUNCHED=""
    while [[ "$LAUNCHED" != "LAUNCHED" ]]
    do
        curl -sX PUT http://gatekeeper:8180/ndb${NDBID}/LAUNCHED
        LAUNCHED=`curl -sL http://gatekeeper:8180/ndb${NDBID}`
        sleep 1
    done

    MANAGEMENT=""

    while [[ "$MANAGEMENT" != "READY" ]] 
    do
        MANAGEMENT=`curl -sL http://gatekeeper:8180/management`
        sleep 1
        echo "Waiting management:$MANAGEMENT"
    done

    #ndbd
    $@

    echo "Sending Ready Signal"

    curl -sX PUT http://gatekeeper:8180/ndb${NDBID}/READY

    while true; do sleep 1000; done

elif [ "$1" = 'mysqld' ]; then

    echo "Sending Launched Signal"

    LAUNCHED=""
    while [[ "$LAUNCHED" != "LAUNCHED" ]]
    do
        curl -sX PUT http://gatekeeper:8180/mysql/LAUNCHED
        LAUNCHED=`curl -sL http://gatekeeper:8180/mysql`
        sleep 1
    done

    echo "Start Waiting for Containers"

    MANAGEMENT=""
    NDB1=""
    NDB2=""

    while [[ "$MANAGEMENT" != "READY" ]]  || [[ "$NDB1" != "READY" ]] || [[ "$NDB2" != "READY" ]]
    do
        MANAGEMENT=`curl -sL http://gatekeeper:8180/management`
        NDB1=`curl -sL http://gatekeeper:8180/ndb1`
        NDB2=`curl -sL http://gatekeeper:8180/ndb2`
        sleep 1
        echo "Waiting: management:$MANAGEMENT; ndb1:$NDB1; ndb2:$NDB2"
    done

    #/entrypoint.sh mysqld
    #mysqld
    /entrypoint.sh $@
    $@

    echo "Sending Ready Signal"

    curl -sX PUT http://gatekeeper:8180/mysql/READY

fi
