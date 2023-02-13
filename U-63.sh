#!/bin/bash

. function.sh
 
BAR

CODE [U-63] ftpusers 파일 소유자 및 권한 설정

cat << EOF >> $result
[양호]: ftpusers 파일의 소유자가 root이고, 권한이 640 이하인 경우
[취약]: ftpusers 파일의 소유자가 root아니거나, 권한이 640 이하가 아닌 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

# Get the original owner and permission settings of the ftpusers file
original_owner=$(stat -c "%U:%G" /etc/vsftpd/ftpusers.bak)
original_permissions=$(stat -c "%a" /etc/vsftpd/ftpusers.bak)

# Change the owner of the ftpusers file back to its original value
sudo chown $original_owner /etc/vsftpd/ftpusers

# Change the permissions of the ftpusers file back to its original value
sudo chmod $original_permissions /etc/vsftpd/ftpusers

# Check the owner and permission settings of the ftpusers file
current_owner=$(stat -c "%U:%G" /etc/vsftpd/ftpusers)
current_permissions=$(stat -c "%a" /etc/vsftpd/ftpusers)
if [ "$current_owner" == "$original_owner" ] && [ "$current_permissions" == "$original_permissions" ]; then
OK "The owner and permission settings of the ftpusers file are set to their original values."
else
INFO "The owner and permission settings of the ftpusers file cannot be set to their original values."
fi

cat $result

echo ; echo