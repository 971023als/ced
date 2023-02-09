#!/bin/bash

. function.sh

BAR

CODE [U-28] NIS , NIS+ 점검		

cat << EOF >> $result

[양호]: NIS 서비스가 비활성화 되어 있거나, 필요 시 NIS+를 사용하는 경우

[취약]: NIS 서비스가 활성화 되어 있는 경우

EOF

BAR

# ypserv 서비스 시작
sudo service ypserv start

# 부팅 시 ypserv 서비스가 시작되도록 설정
sudo update-rc.d ypserv enable

# 바인딩 서비스 시작
sudo service ypbind start

# 부팅 시 시작하도록 유형 바인딩 서비스 설정
sudo update-rc.d ypbind enable

#  ypxfrd 서비스 시작
sudo service ypxfrd start

# 부팅 시 ypxfrd 서비스가 시작되도록 설정
sudo update-rc.d ypxfrd enable

# rpc.yppasswdd 서비스를 시작합니다
sudo service rpc.yppasswdd start

# 부팅 시 rpc.yppasswdd 서비스 사용
sudo update-rc.d rpc.yppasswdd enable

# rpc.yupdate 서비스 시작
sudo service rpc.ypupdated start

# 부팅 시 rpc.ypupdate 서비스 사용
sudo update-rc.d rpc.ypupdated enable

#  ypserv 서비스 시작
sudo service ypserv start

# 부팅 시 ypserv 서비스가 시작되도록 설정
sudo update-rc.d ypserv enable

cat $result

echo ; echo
