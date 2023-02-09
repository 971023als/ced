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

# 원본 /etc/ssh/sshd_config 파일 백업
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# 원본 /etc/ssh/sshd_config 파일 복원
sudo cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config



cat $result

echo ; echo 


 
