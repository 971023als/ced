#!/bin/bash

. function.sh

BAR

CODE [U-09] /etc/hosts 파일 소유자 및 권한 설정

cat << EOF >> $result
[양호]: /etc/hosts 파일의 소유자가 root이고, 권한이 600인 이하경우
[취약]: /etc/hosts 파일의 소유자가 root가 아니거나, 권한이 600 이상인 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

ORIGINAL_OWNER=$(stat -c '%U' /etc/hosts)
ORIGINAL_GROUP=$(stat -c '%G' /etc/hosts)
ORIGINAL_PERMISSIONS=$(stat -c '%a' /etc/hosts)

sudo chown $ORIGINAL_OWNER:$ORIGINAL_GROUP /etc/hosts
sudo chmod $ORIGINAL_PERMISSIONS /etc/hosts

if [ $(stat -c '%U' /etc/hosts) == "$ORIGINAL_OWNER" ] && [ $(stat -c '%G' /etc/hosts) == "$ORIGINAL_GROUP" ] && [ $(stat -c '%a' /etc/hosts) == "$ORIGINAL_PERMISSIONS" ]; then
  OK "The original state of the /etc/hosts file has been restored."
else
  WARN "The original state of the /etc/hosts file could not be restored."
fi




# 하위 파일...

cat $result

echo ; echo