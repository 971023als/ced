#!/bin/bash

. function.sh

BAR

CODE [U-29] tftp, talk 서비스 비활성화		

cat << EOF >> $result
[양호]: tftp, talk, ntalk 서비스가 비활성화 되어 있는 경우
[취약]: tftp, talk, ntalk 서비스가 활성화 되어 있는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# Restore tftp service
if [ -f "/etc/xinetd.d/tftp.bak" ]; then
  sudo mv /etc/xinetd.d/tftp.bak /etc/xinetd.d/tftp
  OK "tftp service restored successfully"
else
  WARN "tftp service has not been restored as it was not backed up"
fi

# Restore talk service
if [ -f "/etc/xinetd.d/talk.bak" ]; then
  sudo mv /etc/xinetd.d/talk.bak /etc/xinetd.d/talk
  OK "talk service restored successfully"
else
  WARN "talk service has not been restored as it was not backed up"
fi

# Restore ntalk service
if [ -f "/etc/xinetd.d/ntalk.bak" ]; then
  sudo mv /etc/xinetd.d/ntalk.bak /etc/xinetd.d/ntalk
  OK "ntalk service restored successfully"
else
  WARN "ntalk service has not been restored as it was not backed up"
fi




cat $result

echo ; echo