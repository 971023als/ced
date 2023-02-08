#!/bin/bash

 

. function.sh

TMP2=$(mktemp)

 

BAR

CODE [U-50] 관리자 그룹에 최소한의 계정 포함

cat << EOF >> $result

양호: 관리자 그룹에 불필요한 계정이 등록되어 있지 않은 경우

취약: 관리자 그룹에 불필요한 계정이 등록되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1


# check if the backup file exists
if [ -f "/path/to/backup/etc_passwd_backup" ]; then
  # restore the backup of the /etc/passwd file
  sudo cp /path/to/backup/etc_passwd_backup /etc/passwd
  # set the correct permissions on the /etc/passwd file
  sudo chmod 644 /etc/passwd
  sudo chown root:root /etc/passwd
  echo "The system has been successfully restored to its original state."
else
  echo "Backup file not found. Unable to restore the system."
fi


 

 

cat $result

echo ; echo
