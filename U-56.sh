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
  OK "UMASK has been successfully removed from /etc/profile."
else
  # Restore the original state of /etc/profile
  sudo cp /etc/profile.bak /etc/profile
  WARN "The original state of /etc/profile could not be restored."
fi

cat $result

echo ; echo