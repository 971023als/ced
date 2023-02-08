#!/bin/bash

. function.sh

BAR

CODE [U-28] NIS , NIS+ 점검		

cat << EOF >> $result

[양호]: NIS 서비스가 비활성화 되어 있거나, 필요 시 NIS+를 사용하는 경우

[취약]: NIS 서비스가 활성화 되어 있는 경우

EOF

BAR



# Start the ypserv service
sudo service ypserv start

# Enable the ypserv service to start at bootup
sudo update-rc.d ypserv enable

# Start ypbind service
sudo service ypbind start

# Set ypbind service to start at boot time
sudo update-rc.d ypbind enable

# Start ypxfrd service
sudo service ypxfrd start

# Enable ypxfrd service to start at bootup
sudo update-rc.d ypxfrd enable

# Start the rpc.yppasswdd service
sudo service rpc.yppasswdd start

# Enable the rpc.yppasswdd service at bootup
sudo update-rc.d rpc.yppasswdd enable

# Start the rpc.yupdated service
sudo service rpc.ypupdated start

# Enable the rpc.ypupdate service at bootup
sudo update-rc.d rpc.ypupdated enable

# Start the ypserv service
sudo service ypserv start

# Enable the ypserv service to start at bootup
sudo update-rc.d ypserv enable



cat $result

echo ; echo
