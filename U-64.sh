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


# /etc/passwd 백업 파일 생성
cp /etc/passwd.bak /etc/passwd

# Get the original state of the ftp service
if [ -f "/tmp/ftp_service.bak" ]; then
original_ftp_service=$(cat "/tmp/ftp_service.bak")
else
WARN "ftp 서비스의 백업 파일이 발견되지 않아서 복원 작업을 수행할 수 없다."
fi

# Restore the original ftp service
if [ -n "$original_ftp_service" ]; then
sudo service "$original_ftp_service" start
if [ $? -eq 0 ]; then
OK "$original_ftp_service 서비스가 시작되었습니다."
else
WARN "$original_ftp_service 서비스를 시작하지 못했습니다."
fi
else
WARN "복원할 대상이 없어서 원래의 상태를 복원할 수 없음."
fi

# Get the original state of the ftp account login shell
if [ -f "/tmp/ftp_shell.bak" ]; then
original_ftp_shell=$(cat "/tmp/ftp_shell.bak")
else
WARN "FTP 계정 로그인 셸의 백업이 발견되지 않았습니다."
fi

# Restore the original login shell of the ftp account
if [ -n "$original_ftp_shell" ]; then
sudo usermod -s "$original_ftp_shell" ftp

# Verify that the login shell of the ftp account has been restored successfully
updated_shell=$(grep "^ftp:" /etc/passwd | cut -d ':' -f 7)
if [ "$updated_shell" == "$original_ftp_shell" ]; then
OK "FTP 계정 로그인 셸이 성공적으로 $original_ftp_shell로 복원되었습니다."
else
WARN "FTP 계정 로그인 셸을 $original_ftp_shell로 복원하지 못했습니다."
fi
else
WARN "원래의 FTP 계정 로그인 셸을 찾을 수 없습니다.."
fi


cat $result

echo ; echo