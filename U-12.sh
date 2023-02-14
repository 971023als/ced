#!/bin/bash

. function.sh

BAR

CODE [U-12] /etc/services 파일 소유자 및 권한 설정		

cat << EOF >> $result
[양호]: etc/services 파일의 소유자가 root(또는 bin, sys)이고, 권한이 644 이하
인 경우
[취약]: etc/services 파일의 소유자가 root(또는 bin, sys)이고, 권한이 644 이하
인 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

ORIG_OWNER=$(stat -c '%U' /etc/services)
ORIG_GROUP=$(stat -c '%G' /etc/services)
ORIG_PERM=$(stat -c '%a' /etc/services)

# Change the owner of the /etc/services file back to the original owner
sudo chown $ORIG_OWNER:$ORIG_GROUP /etc/services

# Set the file permissions back to the original permissions
sudo chmod $ORIG_PERM /etc/services

# Check if the changes were successful and print a message
if [ "$ORIG_OWNER" == "$(stat -c '%U' /etc/services)" ] && [ "$ORIG_GROUP" == "$(stat -c '%G' /etc/services)" ] && [ "$ORIG_PERM" == "$(stat -c '%a' /etc/services)" ]; then
  OK "파일의 원래 상태를 복원."
else
  WARN "파일의 원래 상태를 복원하지 못했음."
fi



cat $result

echo ; echo