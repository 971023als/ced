#!/bin/bash

. function.sh

BAR

CODE [U-54] Session Timeout 설정

cat << EOF >> $result
[양호]: Session Timeout이 600초(10분) 이하로 설정되어 있는 경우
[취약]: Session Timeout이 600초(10분) 이하로 설정되지 않은 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

# Check if TMOUT exists in /etc/profile
if grep -q "TMOUT=600" /etc/profile; then
  # Remove the line containing TMOUT from /etc/profile
  sed -i '/TMOUT=600/d' /etc/profile
  sed -i '/export TMOUT/d' /etc/profile
  INFO "Removed TMOUT from /etc/profile."
else
  OK "TMOUT was not found in /etc/profile."
fi

cat $result

echo ; echo