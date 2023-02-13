#!/bin/bash

. function.sh

BAR

CODE [U-20] Anonymous FTP 비활성화

cat << EOF >> $result

[양호]: Anonymous FTP (익명 ftp) 접속을 차단한 경우

[취약]: Anonymous FTP (익명 ftp) 접속을 차단하지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# vsftpd 구성 파일 백업
cp /etc/vsftpd.conf /etc/vsftpd.conf.bak

# FTP 사용자 복원
sudo useradd ftp

# vsftpd.conf 파일의 경로 설정
vsftpd_conf_file="/etc/vsftpd.conf"

# vsftpd.conf 파일이 있는지 확인합니다.
if [ -f $vsftpd_conf_file ]; then
  # "anonymous_enable=NO" 행을 제거합니다(있는 경우)
  sed -i '/^anonymous_enable=NO/d' $vsftpd_conf_file
else
  # 파일을 찾을 수 없음
  INFO " $vsftpd_conf_file 파일을 찾을 수 없습니다."
fi

# 백업에서 원래 vsftpd.conf 파일 복원
if [ -f $vsftpd_conf_file.bak ]; then
  mv $vsftpd_conf_file.bak $vsftpd_conf_file
fi

INFO "익명 FTP가 원래 상태로 복원되었습니다."




cat $result

echo ; echo