#!/bin/bash

. function.sh

BAR

CODE [U-27] RPC 서비스 확인		

cat << EOF >> $result

[양호]: 불필요한 RPC 서비스가 비활성화 되어 있는 경우

[취약]: 불필요한 RPC 서비스가 활성화 되어 있는 경우

EOF

BAR

# Backup files
cp /etc/xinetd.d/finger /etc/xinetd.d/finger.bak

# /etc/xinetd.d/에서 기존 finger 파일을 제거합니다
if [ -f "/etc/xinetd.d/finger" ]; then
  sudo rm /etc/xinetd.d/finger
fi

# 원본 핑거 파일 다시 만들기
sudo echo "service finger
{
socket_type = stream
wait = no
user = nobody
server = /usr/sbin/in.fingerd
disable = no
}" > /etc/xinetd.d/finger

# xinetd 서비스를 다시 시작하여 변경 사항을 적용합니다
sudo service xinetd restart

# 올바르게 작동하는지 점검하십시오
finger localhost

# 문제가 있는 경우 오류 메시지를 인쇄하고 종료합니다
if [ $? -ne 0 ]; then
  WARN "RPC 핑거 서비스를 원래 상태로 복원할 수 없습니다."
else
  OK "RPC 핑거 서비스가 성공적으로 원래 상태로 복원되었습니다."
fi

cat $result

echo ; echo
