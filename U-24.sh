#!/bin/bash

. function.sh

BAR

CODE [U-24] NFS 서비스 비활성화		

cat << EOF >> $result

[양호]: 불필요한 NFS 서비스 관련 데몬이 비활성화 되어 있는 경우

[취약]: 불필요한 NFS 서비스 관련 데몬이 활성화 되어 있는 경우

EOF

BAR

# Rename the disabled NFS startup script to its original name
if [ -f "/etc/rc.d/rc2.d/_S60nfs" ]; then
mv /etc/rc.d/rc2.d/_S60nfs /etc/rc.d/rc2.d/S60nfs
fi

# Start the NFS related processes
/usr/sbin/nfsd start
/usr/sbin/statd start
/usr/sbin/lockd start



cat $result

echo ; echo
