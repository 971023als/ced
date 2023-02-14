#!/bin/bash

. function.sh

BAR

CODE [U-53] 사용자 shell 점검

cat << EOF >> $result
[양호]: Session Timeout이 600초(10분) 이하로 설정되어 있는 경우
[취약]: Session Timeout이 600초(10분) 이하로 설정되지 않은 경우
EOF

TMP2=/tmp/tmp1

> $TMP2

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

# Backup the original /etc/passwd file
cp /etc/passwd $TMP2

if [ -f $TMP1 ]; then
  # If a problem occurs, restore the original /etc/passwd file
  cp $TMP2 /etc/passwd

  if [ $? -eq 0 ]; then
    OK "성공적으로 복구"
  else
    WARN "문제가 발견되었지만 복구"
  fi
else
  INFO "시스템에 문제가 발견되지 않았다는 것"
fi


cat $result

echo ; echo