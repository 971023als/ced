#!/bin/bash

. function.sh

BAR

CODE [U-38] 웹서비스 불필요한 파일 제거

cat << EOF >> $result
[양호]: 기본으로 생성되는 불필요한 파일 및 디렉터리가 제거되어 있는 경우
[취약]: 기본으로 생성되는 불필요한 파일 및 디렉터리가 제거되지 않은 경우 
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

HTTPD_ROOT="/etc/httpd/conf/httpd.conf"
UNWANTED_ITEMS="manual samples docs"

for item in $UNWANTED_ITEMS
do
if [ ! -d "$HTTPD_ROOT/$item" ] && [ ! -f "$HTTPD_ROOT/$item" ]; then
    sudo cp -r "$HTTPD_ROOT/backup/$item" "$HTTPD_ROOT/$item"
    OK "$item 이 $HTTPD_ROOT 로 복원되었습니다."
else
    WARN "$item 이 $HTTPD_ROOT 로 복원 안 되었습니다."
fi
done

cat $result

echo ; echo