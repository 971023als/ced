#!/bin/bash

. function.sh

BAR

CODE [U-39] 웹서비스 링크 사용금지

cat << EOF >> $result
[양호]: 심볼릭 링크, aliases 사용을 제한한 경우
[취약]: 심볼릭 링크, aliases 사용을 제한하지 않은 경우 
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Defining Apache Configuration Files
file="/etc/httpd/conf/httpd.conf"

# Check if the original state has been recovered
if grep -q "Options FollowSymLinks" $file; then
  WARN "복구 작업 실패."
else
  # Replace "Options" with "Options FollowSymLinks"
  sed -i 's/Options/Options FollowSymLinks/g' $file
  OK "복구 작업 성공."
fi






cat $result

echo ; echo