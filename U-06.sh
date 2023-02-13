#!/bin/bash

. function.sh

BAR

CODE [U-06] 파일 및 디렉터리 소유자 설정

cat << EOF >> $result
[양호]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하지 않는 경우
[취약]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Get the list of files with invalid owners
invalid_owner_files=$(find / -nouser 2>/dev/null)

# Check if there are any files with invalid owners
if [ -z "$invalid_owner_files" ]; then
  OK "No files or directories with invalid owners found"
else
  # Get a list of backup files
  backup_files=$(ls -1 /etc/*.bak 2>/dev/null)

  # Check if there are any backup files
  if [ -z "$backup_files" ]; then
    WARN "No backup files found to restore the original state"
  else
    # Restore the original state
    sudo chown root $backup_files
    OK "The original state has been successfully restored"
  fi
fi



cat $result

echo ; echo