#!/bin/bash

. function.sh

BAR

CODE [U-18] 접속 IP 및 포트 제한

cat << EOF >> $result
[양호]: 접속을 허용할 특정 호스트에 대한 IP 주소 및 포트 제한을 설정한 경우
[취약]: 접속을 허용할 특정 호스트에 대한 IP 주소 및 포트 제한을 설정하지 않은 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Remove the line allowing connections from 192.168.0.1 on port 22 (SSH)
sudo sed -i '/sshd: 192.168.0.1/d' /etc/hosts.allow

# Remove the line denying connections from all other IP addresses on port 22 (SSH)
sudo sed -i '/sshd: ALL/d' /etc/hosts.deny

# Check if the restore was successful
if [ ! -f /etc/hosts.allow ] || [ ! -f /etc/hosts.deny ]; then
  OK "복원 작업  성공"
else
  WARN "복원 작업 실패"
fi



cat $result

echo ; echo