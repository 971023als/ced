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

    OK "Password minimum length setting has been restored to its original state."
  else
    WARN "Password minimum length setting could not be restored to its original state."
  fi
else
  INFO "Password minimum length setting has not been changed."
fi

cat $result

echo ; echo