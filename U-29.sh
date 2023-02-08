#!/bin/bash

. function.sh

BAR

CODE [U-29] tftp, talk 서비스 비활성화		

cat << EOF >> $result

[양호]: tftp, talk, ntalk 서비스가 비활성화 되어 있는 경우

[취약]: tftp, talk, ntalk 서비스가 활성화 되어 있는 경우

EOF

BAR

# Remove tftp, talk, and ntalk files
sudo rm /etc/xinetd.d/tftp
sudo rm /etc/xinetd.d/talk
sudo rm /etc/xinetd.d/ntalk

# Re-enable tftp, talk, and ntalk services
sudo update-rc.d tftp enable
sudo update-rc.d talk enable
sudo update-rc.d ntalk enable

# Start tftp, talk, and ntalk services
sudo service tftp start
sudo service talk start
sudo service ntalk start



cat $result

echo ; echo
