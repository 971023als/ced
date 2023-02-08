#!/bin/bash

 

. function.sh


BAR

CODE [U-67] SNMP 서비스 Community String의 복잡성 설정

cat << EOF >> $result

[양호]: SNMP Community 이름이 public, private 이 아닌 경우

[취약]: SNMP Community 이름이 public, private 인 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1




# File Definitions
file="/etc/snmp/snmpd.conf"
backup_dir="./backup"

# Create the backup directory if it doesn't exist
if [ ! -d "$backup_dir" ]; then
  mkdir "$backup_dir"
fi

# Backup original file
if [ -e "$file" ]; then
  cp "$file" "$backup_dir/$(basename "$file")"
fi

# Restore original file
if [ -e "$backup_dir/$(basename "$file")" ]; then
  cp "$backup_dir/$(basename "$file")" "$file"
  OK "Restored original file $file"
fi

# Clean up backup directory
rm -rf "$backup_dir"



cat $result

echo ; echo 
