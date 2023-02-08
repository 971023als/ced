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


# Check if TMP1 file exists
if [ -f "$TMP1" ]; then
  # Remove the line with 192.168.0.1 from /etc/hosts.allow
  sudo sed -i '/192.168.0.1/d' /etc/hosts.allow

  # Remove the line with "ALL" from /etc/hosts.deny
  sudo sed -i '/ALL/d' /etc/hosts.deny
fi




cat $result

echo ; echo