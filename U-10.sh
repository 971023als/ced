#!/bin/bash

. function.sh

BAR

CODE [U-10] /etc/(x)inetd.conf 파일 소유자 및 권한 설정		

cat << EOF >> $result

[양호]: /etc/inetd.conf 파일의 소유자가 root이고, 권한이 600인 경우

[취약]: /etc/inetd.conf 파일의 소유자가 root가 아니거나, 권한이 600이 아닌 경우

EOF

BAR


ORIG_OWNER=$(stat -c "%U:%G" /etc/xinetd.conf)
ORIG_PERMS=$(stat -c "%a" /etc/xinetd.conf)

# Restore the original owner of the file
sudo chown $ORIG_OWNER /etc/xinetd.conf

# Restore the original permissions of the file
sudo chmod $ORIG_PERMS /etc/xinetd.conf



cat $result

echo ; echo
