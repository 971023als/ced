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

#    백업 파일 생성
cp /etc/xinetd.d/tftp.bak /etc/xinetd.d/tftp
cp /etc/xinetd.d/talk.bak /etc/xinetd.d/talk
cp /etc/xinetd.d/ntalk.bak /etc/xinetd.d/ntalk

# Restore tftp service
if [ -f "/etc/xinetd.d/tftp.bak" ]; then
  sudo mv /etc/xinetd.d/tftp.bak /etc/xinetd.d/tftp
  OK "tftp 서비스가 성공적으로 복원되었습니다"
else
  WARN "tftp 서비스가 백업되지 않았기 때문에 복원되지 않았습니다"
fi

# Restore talk service
if [ -f "/etc/xinetd.d/talk.bak" ]; then
  sudo mv /etc/xinetd.d/talk.bak /etc/xinetd.d/talk
  OK "talk 서비스가 성공적으로 복원되었습니다"
else
  WARN "talk 서비스가 복원되지 않았습니다"
fi

# Restore ntalk service
if [ -f "/etc/xinetd.d/ntalk.bak" ]; then
  sudo mv /etc/xinetd.d/ntalk.bak /etc/xinetd.d/ntalk
  OK "ntalk 서비스가 성공적으로 복원되었습니다"
else
  WARN "ntalk 서비스는 백업되지 않았기 때문에 복원되지 않았습니다"
fi




cat $result

echo ; echo