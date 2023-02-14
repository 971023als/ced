#!/bin/bash

. function.sh

BAR 

CODE [U-08] /etc/shadow 파일 소유자 및 권한 설정

cat << EOF >> $result
[양호]: /etc/shadow 파일의 소유자가 root이고, 권한이 400인 경우
[취약]: /etc/shadow 파일의 소유자가 root가 아니거나, 권한이 400이 아닌 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

ORIG_OWNER=$(stat -c '%U' /etc/shadow)
ORIG_GROUP=$(stat -c '%G' /etc/shadow)
ORIG_PERM=$(stat -c '%a' /etc/shadow)

# Change the owner of the /etc/shadow file back to the original owner
sudo chown $ORIG_OWNER:$ORIG_GROUP /etc/shadow

# Set the file permissions back to the original permissions
sudo chmod $ORIG_PERM /etc/shadow

# Check if the changes were successful and print a message
if [ "$ORIG_OWNER" == "$(stat -c '%U' /etc/shadow)" ] && [ "$ORIG_GROUP" == "$(stat -c '%G' /etc/shadow)" ] && [ "$ORIG_PERM" == "$(stat -c '%a' /etc/shadow)" ]; then
  OK "/etc/shadow 파일이 성공적으로 원래 상태로 복원."
else
  WARN "/etc/shadow 파일의 원래 상태를 복원 불가."
fi


cat $result

echo ; echo