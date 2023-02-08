#!/bin/bash

. function.sh

BAR

CODE [U-19] finger 서비스 비활성화		

cat << EOF >> $result

[양호]: Finger 서비스가 비활성화 되어 있는 경우

[취약]: Finger 서비스가 활성화 되어 있는 경우

EOF

BAR


# Remove the changes made to the finger service configuration file
if [ -f /etc/xinetd.d/finger ]; then
  rm /etc/xinetd.d/finger
fi

# Restore the original finger service configuration file
if [ -f /etc/xinetd.d/finger.bak ]; then
  mv /etc/xinetd.d/finger.bak /etc/xinetd.d/finger
fi

echo "Finger service restored to its original state."


cat $result

echo ; echo
