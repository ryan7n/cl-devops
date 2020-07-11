#!/bin/sh
#
# An example hook script to prepare a packed repository for use over
# dumb transports.
#
# To enable this hook, rename this file to "post-update".


#�ж��ǲ���Զ�˲ֿ�

unset GIT_DIR
DeployPath['cms']="/www/cms"
DeployPath['front']="/www/admin-front"
DeployPath['admin']="/www/admin"

echo "==============================================="

cd $DeployPath  #����web��ĿĿ¼
echo "deploying the web project"

#git stash
#git pull origin master #������ʹ��git pull��������н���

git fetch --all  #����ʹ��git fetch������ȡ����������git pull
git reset --hard origin/master


time=`date`

echo "web server pull at webserver at time: $time."
echo "================================================"