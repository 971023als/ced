#!/bin/bash

. function.sh

BAR

CODE [U-09] /etc/hosts 파일 소유자 및 권한 설정

cat << EOF >> $result

[양호]: /etc/hosts 파일의 소유자가 root이고, 권한이 600인 이하경우

[취약]: /etc/hosts 파일의 소유자가 root가 아니거나, 권한이 600 이상인 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

ORIG_OWNER=$(stat -c "%U:%G" /etc/hosts)
ORIG_PERMS=$(stat -c "%a" /etc/hosts)

# Restore the original owner of the file
sudo chown $ORIG_OWNER /etc/hosts

# Restore the original permissions of the file
sudo chmod $ORIG_PERMS /etc/hosts



# 하위 파일...

cat $result

echo ; echo