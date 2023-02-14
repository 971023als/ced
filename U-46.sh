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

# Check if the PASS_MIN_LEN line exists in the /etc/login.defs file
if grep -q "PASS_MIN_LEN 8" /etc/login.defs; then
  # Remove the PASS_MIN_LEN line from the /etc/login.defs file
  sudo sed -i '/PASS_MIN_LEN 8/d' /etc/login.defs

  # Check if the original value of PASS_MIN_LEN was commented out
  if grep -q "#PASS_MIN_LEN" /etc/login.defs; then
    # Replace "PASS_MIN_LEN" with "#PASS_MIN_LEN"
    sudo sed -i 's/PASS_MIN_LEN/#PASS_MIN_LEN/g' /etc/login.defs

    OK "비밀번호 최소 길이가 성공적으로 원래 상태로 복원."
  else
    WARN "비밀번호 최소 길이를 원래 상태로 복원하지 못했음."
  fi
else
  INFO "메시지는 설정이 변경되지 않았음."
fi

cat $result

echo ; echo