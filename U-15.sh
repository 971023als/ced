#!/bin/bash

. function.sh

BAR

CODE [U-15] world writable 파일 점검

cat << EOF >> $result
[양호]: 시스템 중요 파일에 world writable 파일이 존재하지 않거나, 존재 시 설정 이유를 확인하고 있는 경우
[취약]: 시스템 중요 파일에 world writable 파일이 존재하나 해당 설정 이유를 확인하고 있지 않는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Function to restore file permissions
function restore_permissions() {
  # Check if the world writeable file still exists
  if [ -f "/path/to/world/writeable/file" ]; then
    # Restore the original permissions
    chmod 644 "/path/to/world/writeable/file"
    # Check if the permissions were restored
    if [ `stat -c "%a" "/path/to/world/writeable/file"` == "644" ]; then
      OK "The original permissions have been restored."
    else
      WARN "The original permissions could not be restored."
    fi
  else
    INFO "The world writeable file does not exist."
  fi
}

# Call the function to restore file permissions
restore_permissions



cat $result

echo ; echo