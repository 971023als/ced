#!/bin/bash

. function.sh

BAR

CODE [U-11] /etc/syslog.conf 파일 소유자 및 권한 설정		

cat << EOF >> $result
[양호]: /etc/syslog.conf 파일의 소유자가 root(또는 bin, sys)이고, 권한이 640 이
하인 경우
[취약]: /etc/syslog.conf 파일의 소유자가 root(또는 bin, sys)가 아니거나, 권한이 
640 이하가 아닌 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

ORIG_OWNER=$(stat -c '%U' /etc/rsyslog.conf)
ORIG_GROUP=$(stat -c '%G' /etc/rsyslog.conf)
ORIG_PERM=$(stat -c '%a' /etc/rsyslog.conf)

# Change the owner of the /etc/rsyslog.conf file back to the original owner
sudo chown $ORIG_OWNER:$ORIG_GROUP /etc/rsyslog.conf

# Set the file permissions back to the original permissions
sudo chmod $ORIG_PERM /etc/rsyslog.conf

# Check if the changes were successful and print a message
if [ "$ORIG_OWNER" == "$(stat -c '%U' /etc/rsyslog.conf)" ] && [ "$ORIG_GROUP" == "$(stat -c '%G' /etc/rsyslog.conf)" ] && [ "$ORIG_PERM" == "$(stat -c '%a' /etc/rsyslog.conf)" ]; then
  OK "The original state of /etc/rsyslog.conf has been successfully restored."
else
  WARN "The original state of /etc/rsyslog.conf could not be restored."
fi



cat $result

echo ; echo