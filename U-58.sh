#!/bin/bash

. function.sh

BAR

CODE [U-58] 홈 디렉터리로 지정한 디렉터리의 존재 관리 

cat << EOF >> $result
[양호]: 홈 디렉터리가 존재하지 않는 계정이 발견되지 않는 경우
[취약]: 홈 디렉터리가 존재하지 않는 계정이 발견된 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1 

# Backup the original /etc/passwd file
cp /etc/passwd $TMP2

if [ -f $TMP1 ]; then
  # If a problem occurs, restore the original /etc/passwd file
  cp $TMP2 /etc/passwd

  if [ $? -eq 0 ]; then
    OK "Recovered"
  else
    WARN "Not recovered"
  fi
else
  INFO "No problem detected"
fi


cat $result

echo ; echo