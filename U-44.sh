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

# Check if the UID of an account is changed
username=$(awk -F: '$3==0{print $1}' /etc/passwd)

if [ -n "$username" ]; then
  # Restore the original UID of an account
  usermod -u 0 $username

  if [ $? -eq 0 ]; then
    OK "성공적으로 복원."
  else
    WARN "복원 불가."
  fi
else
  INFO "루트 계정과 동일한 UID를 가진 계정을 찾을 수 없는 경우."
fi

cat $result

echo ; echo