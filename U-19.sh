#!/bin/bash

. function.sh

BAR

CODE [U-19] finger 서비스 비활성화		

cat << EOF >> $result
[양호]: Finger 서비스가 비활성화 되어 있는 경우
[취약]: Finger 서비스가 활성화 되어 있는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# 핑거 서비스 구성 파일의 변경 사항을 제거합니다
if [ -f /etc/xinetd.d/finger ]; then
  sudo rm /etc/xinetd.d/finger
fi

# 원래 핑거 서비스 구성 파일 복원
if [ -f /etc/xinetd.d/finger.bak ]; then
  sudo mv /etc/xinetd.d/finger.bak /etc/xinetd.d/finger
fi

INFO "핑거 서비스가 원래 상태로 복구되었습니다"


cat $result

echo ; echo