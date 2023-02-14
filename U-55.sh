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
  OK "파일의 원래 상태가 복원."
else
  WARN "파일의 원래 상태를 복원할 수 없음."
fi

cat $result

echo ; echo