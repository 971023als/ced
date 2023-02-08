#!/bin/bash

. function.sh

BAR

CODE [U-44] root 이외의 UID가 ‘0’ 금지

cat << EOF >> $result

[양호]: root 계정과 동일한 UID를 갖는 계정이 존재하지 않는 경우

[취약]: root 계정과 동일한 UID를 갖는 계정이 존재하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 


# Save original state of /etc/passwd file
cp /etc/passwd /etc/passwd.bak

# Restore original state of /etc/passwd file
cp /etc/passwd.bak /etc/passwd

# Remove backup file
rm /etc/passwd.bak


cat $result

echo ; echo