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
  OK "원래 상태를 복원."
else
  WARN "원래 상태를 복원할 수 없음."
fi




# 하위 파일...

cat $result

echo ; echo