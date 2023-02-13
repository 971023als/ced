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

# Restore the original state of the ftp service and login shell for the ftp account

# Get the original state of the ftp service
if [ -f "/tmp/ftp_service.bak" ]; then
original_ftp_service=$(cat "/tmp/ftp_service.bak")
else
WARN "Backup of ftp service not found."
fi

# Restore the original ftp service
if [ -n "$original_ftp_service" ]; then
sudo service "$original_ftp_service" start
if [ $? -eq 0 ]; then
OK "$original_ftp_service service started."
else
WARN "Failed to start the $original_ftp_service service."
fi
else
WARN "Original ftp service not found."
fi

# Get the original state of the ftp account login shell
if [ -f "/tmp/ftp_shell.bak" ]; then
original_ftp_shell=$(cat "/tmp/ftp_shell.bak")
else
WARN "Backup of ftp account login shell not found."
fi

# Restore the original login shell of the ftp account
if [ -n "$original_ftp_shell" ]; then
sudo usermod -s "$original_ftp_shell" ftp

# Verify that the login shell of the ftp account has been restored successfully
updated_shell=$(grep "^ftp:" /etc/passwd | cut -d ':' -f 7)
if [ "$updated_shell" == "$original_ftp_shell" ]; then
OK "ftp account login shell restored to $original_ftp_shell successfully."
else
WARN "Failed to restore ftp account login shell to $original_ftp_shell."
fi
else
WARN "Original ftp account login shell not found."
fi


cat $result

echo ; echo