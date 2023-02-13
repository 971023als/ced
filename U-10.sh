#!/bin/bash

. function.sh

BAR

CODE [U-10] /etc/inetd.conf 파일 소유자 및 권한 설정		

cat << EOF >> $result
[양호]: /etc/inetd.conf 파일의 소유자가 root이고, 권한이 600인 경우
[취약]: /etc/inetd.conf 파일의 소유자가 root가 아니거나, 권한이 600이 아닌 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# Check if the file owner is root and permission is 600
if [ "$(stat -c %U /etc/xinetd.conf)" != "root" ] || [ "$(stat -c %a /etc/xinetd.conf)" != "600" ]; then
  # Store the original state of the file
  original_owner=$(stat -c %U /etc/xinetd.conf)
  original_group=$(stat -c %G /etc/xinetd.conf)
  original_permission=$(stat -c %a /etc/xinetd.conf)

  # Restore the original state of the file
  sudo chown adiosl /etc/xinetd.conf
  sudo chmod 644 /etc/xinetd.conf

  OK "The original state of the file /etc/xinetd.conf has been restored."
else
  WARN "The file /etc/xinetd.conf has not been recovered."
fi


cat $result

echo ; echo