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

# Backup the original contents of the file
cp "$file" "$file.bak"

# Replace the modified contents with the original contents from the backup
if [ -e "$file.bak" ]; then
  cp "$file.bak" "$file"
  if [ $? -eq 0 ]; then
    OK "파일 $file 의 원래 상태가 복구되었습니다."
  else
    WARN "파일 $file 의 원래 상태를 복구하지 못했음을 나타냅니다."
  fi
else
  INFO "$file.bak 파일이 존재하지 않습니다."
fi

cat $result

echo ; echo