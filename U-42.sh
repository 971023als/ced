#!/bin/bash

. function.sh 

BAR

CODE [U-42] 최신 보안패치 및 벤더 권고사항 적용

cat << EOF >> $result

[양호]: 패치 적용 정책을 수립하여 주기적으로 패치를 관리하고 있는 경우

[취약]: 패치 적용 정책을 수립하지 않고 주기적으로 패치관리를 하지 않는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# CentOS 6.9에 대한 저장소 사용
sudo yum --enablerepo=C6.9-base list kernel-2.6.32-642*

# CentOS 6.9용 커널 설치
sudo yum install kernel-2.6.32-642.el6

# 시스템을 재부팅하여 변경 사항을 적용합니다
sudo reboot

# 레드햇 릴리스 다운그레이드
sudo yum --enablerepo=C6.9-base downgrade redhat-release



cat $result

echo ; echo 

 
