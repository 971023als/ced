#!/bin/bash

. function.sh

BAR

CODE [U-02] 패스워드 복잡성 설정

cat << EOF >> $result

[양호]: 패스워드 최소길이 8자리 이상, 영문·숫자·특수문자 최소 입력 기능이 설정된 경우

[취약]: 패스워드 최소길이 8자리 이상, 영문·숫자·특수문자 최소 입력 기능이 설정된 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

DEF_FILE="/etc/login.defs"
AUTH_FILE="/etc/pam.d/system-auth"

# Restore /etc/login.defs to its original state
if [ -f "$DEF_FILE.bak" ]; then
  sudo cp "$DEF_FILE.bak" "$DEF_FILE"
  OK "The original state of $DEF_FILE has been restored."
else
  WARN "$DEF_FILE.bak not found. $DEF_FILE has not been restored."
fi

# Restore /etc/pam.d/system-auth to its original state
if [ -f "$AUTH_FILE.bak" ]; then
  sudo cp "$AUTH_FILE.bak" "$AUTH_FILE"
  OK "The original state of $AUTH_FILE has been restored."
else
  WARN "$AUTH_FILE.bak not found. $AUTH_FILE has not been restored."
fi


cat $result

echo ; echo