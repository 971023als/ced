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

# Check if the NFS service is running correctly by mounting and accessing an NFS share
sudo mount <NFS_server_IP>:<NFS_share_path> <local_mount_point>
ls <local_mount_point>

# If there's an issue, print an error message and exit
if [ $? -ne 0 ]; then
  echo "Error: NFS service could not be restored to its original state"
  exit 1
fi

echo "NFS service has been successfully restored to its original state"



cat $result

echo ; echo
