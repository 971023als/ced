#!/bin/bash

. function.sh

BAR

CODE [U-08] /etc/shadow 파일 소유자 및 권한 설정		

cat << EOF >> $result

[양호]: /etc/shadow 파일의 소유자가 root이고, 권한이 400 이하인 경우

[취약]: /etc/shadow 파일의 소유자가 root가 아니거나, 권한이 400 이하가 아닌 경우

EOF

BAR

# Backup files
cp /etc/shadow /etc/shadow.bak

# 파일 소유자를 "root" 사용자와 "root" 그룹으로 변경
sudo chown root:root /etc/shadow

# 파일의 권한을 400으로 설정
sudo chmod 400 /etc/shadow

cat $result

echo ; echo
