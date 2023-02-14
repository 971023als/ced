#!/bin/bash

. function.sh

BAR

CODE [U-26] automountd 제거		

cat << EOF >> $result
[양호]: automountd 서비스가 비활성화 되어 있는 경우
[취약]: automountd 서비스가 활성화 되어 있는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# Restore the Auto Mount service by renaming the startup script
if [ -f "/etc/rc.d/rc2.d/_S28automountd" ]; then
sudo mv /etc/rc.d/rc2.d/_S28automountd /etc/rc.d/rc2.d/S28automountd
fi

# Start the Auto Mount service
sudo service automount start

# Check if the Auto Mount service is running
if ps -ef | grep automount | awk '{print $1}' | grep -q "online"; then
  OK "성공적으로 복원."
else
  WARN "복원 실패."
fi



cat $result

echo ; echo