#!/bin/bash

. function.sh

BAR

CODE [U-10] /etc/inetd.conf 파일 소유자 및 권한 설정		

cat << EOF >> $result

[양호]: /etc/inetd.conf 파일의 소유자가 root이고, 권한이 600인 경우

[취약]: /etc/inetd.conf 파일의 소유자가 root가 아니거나, 권한이 600이 아닌 경우

EOF

BAR

# Backup files
cp /etc/xinetd.conf /etc/xinetd.conf.bak

# 파일 소유자를 "root" 사용자와 "root" 그룹으로 변경
sudo chown root:root /etc/xinetd.conf

# 파일의 권한을 600으로 설정
sudo chmod 600 /etc/xinetd.conf

cat $result

echo ; echo
