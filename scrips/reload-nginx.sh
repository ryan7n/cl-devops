#!/bin/sh

# ���ӵ��ļ���Ŀ¼
filename=$1

# ���ӷ���������ɾ����ʱִ�еĽű�
script=1

inotifywait -mrq --format '%e' --event create,delete,modify  $filename | while read event
  do
      case $event in MODIFY|CREATE|DELETE) (echo $event;cd ../devops &&  echo $PWD && /usr/local/bin/docker-compose -f docker-compose.yml restart webserver)  ;;
      esac
  done