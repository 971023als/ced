#!/bin/bash

. function.sh

BAR

CODE [U-35] 웹서비스 디렉토리 리스팅 제거

cat << EOF >> $result

[양호]: 디렉터리 검색 기능을 사용하지 않는 경우

[취약]: 디렉터리 검색 기능을 사용하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# Restart Apache service
sudo systemctl restart httpd

# Check if Apache service is running
if systemctl is-active --quiet httpd; then
  OK "Apache service has been successfully restored."
else
  WARN "Apache service has not been restored."
fi



cat $result

echo ; echo