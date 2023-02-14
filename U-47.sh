#!/bin/bash

. function.sh

BAR

CODE [U-47] 패스워드 최대 사용기간 설정

cat << EOF >> $result
[양호]: 패스워드 최대 사용기간이 90일(12주) 이하로 설정되어 있는 경우
[취약]: 패스워드 최대 사용기간이 90일(12주) 이하로 설정되어 있지 않는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

DEF_FILE="/etc/login.defs"
TMP1=`SCRIPTNAME`.log

# Check if the temporary file exists
if [ -f "$TMP1" ]; then
  # Get the original password maximum age value from the temporary file
  original_value=$(cat $TMP1)

  # Set the original password maximum age value
  sudo sed -i "s/^PASS_MAX_DAYS.*/$original_value/" "$DEF_FILE"

  OK "T임시 파일이 존재하지 않아 원래의 암호 최대 사용 기간 값을 복구했음."
else
  WARN "임시 파일이 존재하지 않아 원래의 암호 최대 사용 기간 값을 복구하지 못했음."
fi

cat $result

echo ; echo