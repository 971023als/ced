#!/bin/bash

. function.sh

BAR

CODE [U-46] 패스워드 최소 길이 설정

cat << EOF >> $result

[양호]: 패스워드 최소 길이가 8자 이상으로 설정되어 있는 경우 

[취약]: 패스워드 최소 길이가 8자 미만으로 설정되어 있는 경우 

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