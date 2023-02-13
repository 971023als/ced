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

# Start the NFS service
sudo service nfs start

# Check the status of the NFS service
sudo service nfs status

sudo mount 192.168.0.100:/nfs_share /mnt/nfs

# Check if the NFS share is mounted correctly by accessing it
ls /mnt/nfs

# Check if the NFS service is running
if sudo service nfs status | grep -q "is running"; then
  OK "NFS service restored successfully."
else
  WARN "NFS service could not be restored."
fi



cat $result

echo ; echo
