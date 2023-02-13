#!/bin/bash

. function.sh
 
BAR

CODE [U-55] hosts.lpd 파일 소유자 및 권한 설정

cat << EOF >> $result
[양호]: 파일의 소유자가 root이고 권한이 600인 경우
[취약]: 파일의 소유자가 root가 아니고 권한이 600이 아닌 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

if [ -f /etc/hosts.lpd.bak ]; then
  sudo cp /etc/hosts.lpd.bak /etc/hosts.lpd
  OK "The original state of the file has been restored."
else
  WARN "The backup file could not be found. The original state of the file could not be restored."
fi

cat $result

echo ; echo