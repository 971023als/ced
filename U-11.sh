#!/bin/bash

. function.sh

BAR

CODE [U-11] /etc/syslog.conf 파일 소유자 및 권한 설정		

cat << EOF >> $result

[양호]: /etc/syslog.conf 파일의 소유자가 root(또는 bin, sys)이고, 권한이 640 이
하인 경우

[취약]: /etc/syslog.conf 파일의 소유자가 root(또는 bin, sys)가 아니거나, 권한이 
640 이하가 아닌 경우

EOF

BAR


ORIG_OWNER=$(stat -c "%U:%G" /etc/rsyslog.conf)
ORIG_PERMS=$(stat -c "%a" /etc/rsyslog.conf)

# Restore the original owner of the file
sudo chown $ORIG_OWNER /etc/rsyslog.conf

# Restore the original permissions of the file
sudo chmod $ORIG_PERMS /etc/rsyslog.conf


cat $result

echo ; echo
