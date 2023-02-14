#!/bin/bash

. function.sh

BAR

CODE [U-56] UMASK 설정 관리 

cat << EOF >> $result
[양호]: UMASK 값이 022 이하로 설정된 경우
[취약]: UMASK 값이 022 이하로 설정되지 않은 경우 
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1 

# Backup the original state of /etc/profile
sudo cp /etc/profile /etc/profile.bak

# Remove the UMASK setting from /etc/profile
sudo sed -i '/UMASK/d' /etc/profile

# Check if UMASK has been removed from /etc/profile
if ! grep -q "UMASK=022" /etc/profile; then
  OK "/etc/profile의 원래 상태를 복원할 수 있는 경우."
else
  # Restore the original state of /etc/profile
  sudo cp /etc/profile.bak /etc/profile
  WARN "/etc/profile의 원래 상태를 복원할 수 없는 경우"
fi

cat $result

echo ; echo