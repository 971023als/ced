#!/bin/bash

. function.sh

BAR

CODE [U-23] DoS 공격에 취약한 서비스 비활성화		

cat << EOF >> $result

[양호]: 사용하지 않는 DoS 공격에 취약한 서비스가 비활성화 된 경우

[취약]: 사용하지 않는 DoS 공격에 취약한 서비스가 활성화 된 경우

EOF

BAR

# Remove the echo file
rm /etc/xinetd.d/echo

# Remove the discard file
rm /etc/xinetd.d/discard

# Remove the daytime file
rm /etc/xinetd.d/daytime

# Remove the chargen file
rm /etc/xinetd.d/chargen

# Restart the xinetd service
sudo service xinetd restart


cat $result

echo ; echo
