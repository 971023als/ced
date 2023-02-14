#!/bin/bash

 

. function.sh
 

BAR

CODE [U-64] ftpusers 파일 설정

cat << EOF >> $result

[양호]: FTP 서비스가 비활성화 되어 있거나, 활성 시 root 계정 접속을 차단한 경우

[취약]: FTP 서비스가 활성화 되어 있고, root 계정 접속을 허용한 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1 


ftp_user="ftpuser"

if ! grep "^$ftp_user" /etc/passwd > /dev/null 2>&1; then
  sudo useradd $ftp_user
fi

if [ "$(id -u)" == "0" ]; then
  if [ "$(grep "^ftp" /etc/passwd | cut -d: -f1)" == "root" ]; then
    sudo usermod -s /usr/sbin/nologin root
    OK "루트 FTP 액세스가 비활성화되었습니다."
  fi
  sudo usermod -s /bin/false $ftp_user
  OK "FTP 액세스가 $ftp_user 계정으로 제한되었습니다."
else
  WARN "루트로 실행해야 합니다."
fi



cat $result

echo ; echo 


 
