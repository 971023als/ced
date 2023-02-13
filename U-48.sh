#!/bin/bash

. function.sh

BAR

CODE [U-48] 패스워드 최소 사용기간 설정

cat << EOF >> $result
[양호]: 패스워드 최소 사용기간이 1일(1주)로 설정되어 있는 경우
[취약]: 패스워드 최소 사용기간이 설정되어 있지 않는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

DEF_FILE="/etc/login.defs"

# Backup the /etc/login.defs file
sudo cp "$DEF_FILE" "$DEF_FILE.bak"

# Run the original script
./u48.sh

# Check if the result file has the vulnerable message
if grep -q "Vulnerable: Password minimum age is not set" $result; then
  # Restore the original /etc/login.defs file
  sudo cp "$DEF_FILE.bak" "$DEF_FILE"
  OK "The system has been restored to its original state."
else
  WARN "The system is not vulnerable."
fi

cat $result

echo ; echo