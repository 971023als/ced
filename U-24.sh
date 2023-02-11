#!/bin/bash

. function.sh

BAR

CODE [U-24] NFS 서비스 비활성화		

cat << EOF >> $result

[양호]: 불필요한 NFS 서비스 관련 데몬이 비활성화 되어 있는 경우

[취약]: 불필요한 NFS 서비스 관련 데몬이 활성화 되어 있는 경우

EOF

BAR

# NFS 서비스가 설치되어 있는지 확인합니다
if ! command -v nfsd &> /dev/null; then
  INFO "NFS 서비스가 설치되지 않았습니다. 복원을 중단하는 중입니다."
else
  INFO "NFS 서비스가 설치되었습니다. 복원 중입니다."
fi

# dfstab 또는 내보내기에서 공유 복원
if [ -f "/etc/dfs/dfstab.bak" ]; then
  cp "/etc/dfs/dfstab.bak" "/etc/dfs/dfstab"
  INFO "/etc/dfs/dfstab에서 복원된 공유"
elif [ -f "/etc/exports.bak" ]; then
  cp "/etc/exports.bak" "/etc/exports"
  INFO "/etc/exports에서 복원된 공유."
else
  INFO "공유 백업 파일을 찾을 수 없습니다."
fi

# Start NFS services
services=("nfsd" "statd" "mountd")

for service in "${services[@]}"; do
  service "$service" start
  if [ $? -eq 0 ]; then
    INFO "$service 가 성공적으로 시작되었습니다."
  else 
    INFO "$service 를 시작하지 못했습니다."
  fi
done

# 사용하지 않도록 설정된 NFS 시작 스크립트의 이름을 원래 이름으로 변경합니다
if [ -f "/etc/rc.d/rc2.d/_S60nfs" ]; then
sudo mv /etc/rc.d/rc2.d/_S60nfs /etc/rc.d/rc2.d/S60nfs
fi

# NFS 관련 프로세스 시작
/usr/sbin/nfsd restart
/usr/sbin/statd restart
/usr/sbin/lockd restart


cat $result

echo ; echo
