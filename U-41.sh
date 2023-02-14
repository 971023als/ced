#!/bin/bash

. function.sh

BAR

CODE [U-41] 웹서비스 영역의 분리

cat << EOF >> $result
[양호]: DocumentRoot를 별도의 디렉터리로 지정한 경우
[취약]: DocumentRoot를 기본 디렉터리로 지정한 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Define the Apache configuration file
file="/etc/httpd/conf/httpd.conf"

# Check if the DocumentRoot has been changed
if grep -q "/home/ubuntu/newphp/" $file; then
  # Replace the DocumentRoot with the original default path "/var/www/html"
  sed -i 's|DocumentRoot.*|DocumentRoot "/var/www/html"|' $file
  OK "The original state has been restored."
else
  WARN "The original state has not been recovered."
fi

cat $result

echo ; echo