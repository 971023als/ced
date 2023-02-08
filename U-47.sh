#!/bin/bash

. function.sh

BAR

CODE [U-47] 패스워드 최대 사용기간 설정

cat << EOF >> $result

[양호]: 패스워드 최대 사용기간이 90일(12주) 이하로 설정되어 있는 경우

[취약]: 패스워드 최대 사용기간이 90일(12주) 이하로 설정되어 있지 않는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


TMP2=`SCRIPTNAME`.bak

# Backup the original /etc/login.defs file
cp /etc/login.defs $TMP2

# Restore the original /etc/login.defs file
cp $TMP2 /etc/login.defs

# Remove the backup file
rm $TMP2


cat $result

echo ; echo