#!/bin/bash

. function.sh

BAR

CODE [U-40] 웹서비스 파일 업로드 및 다운로드 제한

cat << EOF >> $result
[양호]: 파일 업로드 및 다운로드를 제한한 경우
[취약]: 파일 업로드 및 다운로드를 제한하지 않은 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Define the Apache configuration file
file="/etc/httpd/conf/httpd.conf"

# Check if the LimitRequestBody directive has been added
if grep -q "LimitRequestBody" $file; then
  # Remove the LimitRequestBody directive from the file
  sed -i '/LimitRequestBody/d' $file
  OK "파일의 상태가 복원됨."
else
  WARN "파일의 상태가 복원되지 않음."
fi


cat $result

echo ; echo