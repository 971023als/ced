#!/bin/bash

 

. function.sh

TMP1=`SCRIPTNAME`.log

> $TMP1

 

BAR

CODE [U-48] 패스워드 최소 사용기간 설정

cat << EOF >> $result

[양호]: 패스워드 최소 사용기간이 1일(1주)로 설정되어 있는 경우

[취약]: 패스워드 최소 사용기간이 설정되어 있지 않는 경우

EOF

BAR


# Check if the log file exists
if [ -f $TMP1 ]; then
  # Get the original setting from the log file
  original_setting=$(cat $TMP1)
  
  # Restore the original setting
  echo "$original_setting" > /etc/login.defs
  
  # Validate the restoration
  if [ $(cat /etc/login.defs) == "$original_setting" ]; then
    echo "System successfully restored to its original state."
  else
    echo "Failed to restore the system to its original state."
  fi
else
  echo "Cannot find log file to restore the original state."
fi

 

cat $result

echo ; echo
