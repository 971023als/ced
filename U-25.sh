#!/bin/bash

. function.sh

BAR

CODE [U-25] NFS 접근 통제		

cat << EOF >> $result

[양호]: 불필요한 NFS 서비스를 사용하지 않거나, 불가피하게 사용 시 everyone 
공유를 제한한 경우

[취약]: 불필요한 NFS 서비스를 사용하고 있고, everyone 공유를 제한하지 않은 
경우

EOF

BAR


INFO "이 부분은 백업 파일 관련한 항목이 아닙니다"

#----------------------------------------------------------------------


# NFS 서비스 시작
sudo systemctl start nfs-kernel-server

# NFS 서비스의 상태를 확인
if sudo systemctl status nfs-kernel-server | grep -q 'active (running)'; then
  OK "NFS 서비스가 성공적으로 시작되었습니다."
else
  WARN "NFS 서비스를 시작하지 못했습니다."
fi

cat $result

echo ; echo
