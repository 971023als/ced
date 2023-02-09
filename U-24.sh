#!/bin/bash

. function.sh

BAR

CODE [U-24] NFS 서비스 비활성화		

cat << EOF >> $result

[양호]: 불필요한 NFS 서비스 관련 데몬이 비활성화 되어 있는 경우

[취약]: 불필요한 NFS 서비스 관련 데몬이 활성화 되어 있는 경우

EOF

BAR

# Backup NFS configuration files
cp /etc/dfs/dfstab /etc/dfs/dfstab.bak
cp /etc/exports /etc/exports.bak

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
