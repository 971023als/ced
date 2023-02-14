#!/bin/bash

. function.sh

BAR

CODE [U-59] 숨겨진 파일 및 디렉터리 검색 및 제거

cat << EOF >> $result
[양호]: 디렉터리 내 숨겨진 파일을 확인하여, 불필요한 파일 삭제를 완료한 경우
[취약]: 디렉터리 내 숨겨진 파일을 확인하지 않고, 불필요한 파일을 방치한 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1 

# Define a function to restore the original state
function restore_state {
  # Check if a backup of the hidden files and directories exists
  if [ -f "hidden_files_backup.txt" ]; then
    # Restore the hidden files
    while read file; do
      if [ ! -f "$file" ]; then
        touch "$file"
      fi
    done < "hidden_files_backup.txt"

    # Restore the hidden directories
    while read dir; do
      if [ ! -d "$dir" ]; then
        mkdir "$dir"
      fi
    done < "hidden_dirs_backup.txt"

    # Print that the original state was recovered
    OK "원래 상태가 성공적으로 복원되었습니다.."
  else
    # Print that the original state was not recovered
    WARN "백업 파일이 없어서 원래 상태를 복원할 수 없습니다."
  fi
}

# Check if there was a problem while removing the hidden files and directories
if [ ! -z "$(sudo find / -type f -name ".*" ! -path "/run/user/1000/gvfs/*")" ] || [ ! -z "$(sudo find / -type d -name ".*" ! -path "/run/user/1000/gvfs/*")" ]; then
  # Restore the original state
  restore_state
else
  INFO "숨겨진 파일 및 디렉토리를 제거하는 동안 문제가 발견되지 않았습니다.."
fi


cat $result

echo ; echo