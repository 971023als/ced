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

# Backup the original /etc/profile file
sudo cp /etc/profile /etc/profile.bak

# Restore the original /etc/profile file
sudo cp /etc/profile.bak /etc/profile

echo "The file has been restored to its original state."

# Remove the backup file
sudo rm -rf /etc/profile.bak






cat $result

echo ; echo 

 
