#!/bin/sh
#
# An example hook script to prepare a packed repository for use over
# dumb transports.
#
# To enable this hook, rename this file to "post-update".



unset GIT_DIR
DeployPath="/www/"

echo "==============================================="

echo "deploying the web project"
Name=`/opt/bitnami/phabricator/bin/repository discover R"$(basename $(pwd))" |awk -F'"' '{print $2}' |head -n1`

cd $DeployPath$Name

echo "current $PWD"
echo "user: $(id)"
#git stash
#git pull origin master


git fetch --all
git reset --hard origin/master

is_npm=$(echo $Name|grep 'front')
if [ $is_npm != "" ]
then npm run build
fi
time=`date`

echo "web server pull at webserver at time: $time."
echo "================================================"

