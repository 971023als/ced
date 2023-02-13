#!/bin/bash

. function.sh

BAR

CODE [U-21] r 계열 서비스 비활성화		

cat << EOF >> $result
[양호]: 불필요한 r 계열 서비스가 비활성화 되어 있는 경우
[취약]: 불필요한 r 계열 서비스가 활성화 되어 있는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# Backup files
cp /etc/xinetd.d/rlogin /etc/xinetd.d/rlogin.bak
cp /etc/xinetd.d/rsh /etc/xinetd.d/rsh.bak
cp /etc/xinetd.d/rexec /etc/xinetd.d/rexec.bak

# /etc/xinetd.d/rlogin 파일 복원
if [ -f /etc/xinetd.d/rlogin.bak ]; then
  sudo mv /etc/xinetd.d/rlogin.bak /etc/xinetd.d/rlogin
else
  INFO "/etc/xinetd.d/rlogin.bak을 찾을 수 없습니다."
fi

# /etc/xinetd.d/rsh 파일 복원
if [ -f /etc/xinetd.d/rsh.bak ]; then
  sudo mv /etc/xinetd.d/rsh.bak /etc/xinetd.d/rsh
else
  INFO "/etc/xinetd.d/rsh.bak을 찾을 수 없습니다."
fi

# /etc/xinetd.d/exec 파일 복원
if [ -f /etc/xinetd.d/rexec.bak ]; then
  sudo mv /etc/xinetd.d/rexec.bak /etc/xinetd.d/rexec
else
  INFO "/etc/xinetd.d/exec.bak을 찾을 수 없습니다."
fi

INFO "r 서비스가 원래 상태로 복구되었습니다."

cat $result

echo ; echo