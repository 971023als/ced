#!/bin/bash


. function.sh

BAR

CODE [U-72] 정책에 따른 시스템 로깅 설정

cat << EOF >> $result
[양호]: 로그 기록 정책이 정책에 따라 설정되어 수립되어 있는 경우
[취약]: 로그 기록 정책이 정책에 따라 설정되어 수립되어 있지 않은 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1 

filename="/etc/rsyslog.conf"

if [ ! -e "$filename" ]; then
INFO "$filename does not exist"
fi

# Create a backup of the original file
if [ ! -e "$filename.bak" ]; then
cp "$filename" "$filename.bak"
fi

# Restore the original file from the backup
cp "$filename.bak" "$filename"

# Check if the original file was restored successfully
difference=$(diff "$filename" "$filename.bak")
if [ -z "$difference" ]; then
    OK "복구 완료: $filename"
else
    WARN "복구 불가능: $filename"
fi


cat $result

echo ; echo