#!/bin/bash

if [ -z "$1" ]
then
    echo "請輸入 domain"
    exit
fi

ip=$(dig @8.8.8.8 +short $1)

if [ -z $ip ]
then
    echo "解析 DoT Domain 失敗。"
    exit
fi

QUERY=twnic.net.tw

kdig +tls-host=$1 @$ip $QUERY +noall +answer +stats | grep -oEe "\b([0-9]{1,3}\.){3}[0-9]{1,3}$" -oEe 'in [0-9]+\.[0-9]+ ms'
