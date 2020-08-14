#!/bin/bash

#crontab -l >/tmp/mycron
basepath=$(cd `dirname $0`; pwd)

echo "* * * * * flocak /tmp/rn $basepath/reload-nginx.sh $basepath/../nginx/conf.d"

