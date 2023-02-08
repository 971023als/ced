#!/bin/bash

. function.sh

BAR

CODE [U-01] root 계정 원격 접속 제한

cat << EOF >> $result

[양호]: 원격 서비스를 사용하지 않거나 사용시 직접 접속을 차단한 경우

[취약]: root 직접 접속을 허용하고 원격 서비스를 사용하는 경우

EOF

BAR


# Restore /etc/pam.d/login to its original state
sudo mv /etc/pam.d/login.bak /etc/pam.d/login

# Restore /etc/securety to its original state
sudo mv /etc/securety.bak /etc/securety



cat $result

echo ; echo