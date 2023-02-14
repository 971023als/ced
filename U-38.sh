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

HTTPD_ROOT="/etc/apache2/apache2.conf"
UNWANTED_ITEMS="manual samples docs"
BACKUP_DIR="/root/httpd_backup"

# 원하지 않는 파일 백업
mkdir -p "$BACKUP_DIR"
for item in $UNWANTED_ITEMS
do
  if [ -d "$HTTPD_ROOT/$item" ] || [ -f "$HTTPD_ROOT/$item" ]; then
    cp -r "$HTTPD_ROOT/$item" "$BACKUP_DIR"
    INFO "$item이 $HTTPD_ROOT에서 $BACKUP_DIR로 백업되었습니다"
  fi
done

#------------------------------------------------------------------

HTTPD_ROOT="/etc/apache2/apache2.conf"
UNWANTED_ITEMS="manual samples docs"
BACKUP_DIR="/root/httpd_backup"

# 백업 파일 복원
if [ -d "$BACKUP_DIR" ]; then
  for item in $UNWANTED_ITEMS
  do
    if [ -d "$BACKUP_DIR/$item" ] || [ -f "$BACKUP_DIR/$item" ]; then
      cp -r "$BACKUP_DIR/$item" "$HTTPD_ROOT"
      INFO "$item이 $BACKUP_DIR에서 $HTTPD_ROOT로 복원되었습니다."
    fi
  done
else
  WARN "백업 디렉터리 $BACKUP_DIR이 없습니다."
fi

echo ; echo