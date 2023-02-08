#!/bin/bash

. function.sh

BAR

CODE [U-27] RPC 서비스 확인		

cat << EOF >> $result

[양호]: 불필요한 RPC 서비스가 비활성화 되어 있는 경우

[취약]: 불필요한 RPC 서비스가 활성화 되어 있는 경우

EOF

BAR


# Remove the existing finger file in /etc/xinetd.d/
if [ -f "/etc/xinetd.d/finger" ]; then
rm /etc/xinetd.d/finger
fi

# Recreate the original finger file
echo "service finger
{
socket_type = stream
wait = no
user = nobody
server = /usr/sbin/in.fingerd
disable = no
}" > /etc/xinetd.d/finger

# Restart the xinetd service to apply the changes
service xinetd restart

# Check if the finger service is working correctly
finger localhost

# If there's an issue, print an error message and exit
if [ $? -ne 0 ]; then
  echo "Error: RPC finger service could not be restored to its original state"
  exit 1
fi

echo "RPC finger service has been successfully restored to its original state"


cat $result

echo ; echo
