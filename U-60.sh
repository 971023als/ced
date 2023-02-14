#!/bin/bash

. function.sh

BAR

CODE [U-60] ssh 원격접속 허용

cat << EOF >> $result
[양호]: 원격 접속 시 SSH 프로토콜을 사용하는 경우
[취약]: 원격 접속 시 Telnet, FTP 등 안전하지 않은 프로토콜을 사용하는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1  

# Check if SSH is installed
if [ ! -f /usr/sbin/sshd ]; then
echo "SSH is not installed."

# Uninstall SSH
sudo yum remove ssh -y

# Check if SSH has been successfully uninstalled
if [ ! -f /usr/sbin/sshd ]; then
OK "SSH 제거 작업 성공."
else
WARN "SSH 제거 작업 실패."
fi
else
INFO "SSH 이미 제거."
fi

cat $result

echo ; echo