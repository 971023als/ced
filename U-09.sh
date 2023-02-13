#!/bin/bash

. function.sh

BAR

CODE [U-09] /etc/hosts 파일 소유자 및 권한 설정

cat << EOF >> $result

[양호]: /etc/hosts 파일의 소유자가 root이고, 권한이 600인 이하경우

[취약]: /etc/hosts 파일의 소유자가 root가 아니거나, 권한이 600 이상인 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Backup files
cp /etc/hosts /etc/hosts.bak

# 파일 소유자를 "root" 사용자와 "root" 그룹으로 변경
sudo chown root:root /etc/hosts

# 파일의 권한을 600으로 설정
sudo chmod 600 /etc/hosts


cat $result

echo ; echo