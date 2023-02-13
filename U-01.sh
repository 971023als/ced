#!/bin/bash

. function.sh

BAR

CODE [U-01] root 계정 원격 접속 제한

cat << EOF >> $result

[양호]: 원격 서비스를 사용하지 않거나 사용시 직접 접속을 차단한 경우

[취약]: root 직접 접속을 허용하고 원격 서비스를 사용하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 


# Check if the original files were modified
diff /etc/securety /etc/securety.bak > /dev/null
securety_diff=$?

diff /etc/pam.d/login /etc/pam.d/login.bak > /dev/null
login_diff=$?

if [ $securety_diff -ne 0 ] || [ $login_diff -ne 0 ]; then
  INFO "Recovering original state of /etc/securety and /etc/pam.d/login files..."
  # Replace the modified files with the backup files
  cp /etc/securety.bak /etc/securety
  cp /etc/pam.d/login.bak /etc/pam.d/login
  OK "Original state recovered."
else
  WARN "Original state was not recovered."
fi



cat $result

echo ; echo