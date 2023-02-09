#!/bin/bash

. function.sh

BAR

CODE [U-26] automountd 제거		

cat << EOF >> $result

[양호]: automountd 서비스가 비활성화 되어 있는 경우

[취약]: automountd 서비스가 활성화 되어 있는 경우

EOF

BAR


# Enable the Auto Mount service by changing the name of the startup script
if [ -f "/etc/rc.d/rc2.d/_S28automountd" ]; then
mv /etc/rc.d/rc2.d/_S28automountd /etc/rc.d/rc2.d/S28automountd
fi

# Check the status of the Auto Mount service
status=$(ps -ef | grep automount | awk '{print $1}')

# If the service is not running, start the service
if [ "$status" != "online" ]; then
/etc/rc.d/init.d/automount start
fi

# Check the status of the Auto Mount service again
status=$(ps -ef | grep automount | awk '{print $1}')

# If the service is not running, print an error message and exit
if [ "$status" != "online" ]; then
  echo "Error: Auto Mount service could not be restored to its original state"
fi

echo "Auto Mount service has been successfully restored to its original state"


cat $result

echo ; echo
