#!/bin/bash

. function.sh

BAR

CODE [U-51] 계정이 존재하지 않는 GID 금지

cat << EOF >> $result
양호: 존재하지 않는 계정에 GID 설정을 금지한 경우
취약: 존재하지 않은 계정에 GID 설정이 되어있는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# Get the original groups from the backup file
ORIGINAL_GROUPS=$(cat /etc/group.bak | cut -d: -f1)

# Add the original groups back to the system
for group in $ORIGINAL_GROUPS; do
  sudo groupadd "$group"
done

# Check if the original groups were successfully added back
CURRENT_GROUPS=$(cut -d: -f1 /etc/group)
for group in $ORIGINAL_GROUPS; do
  if ! [[ "$CURRENT_GROUPS" =~ "$group" ]]; then
    WARN "각 그룹의 기본값이 복원 불가: $group"
  fi
done

OK "각 그룹의 기본값이 복원."


cat $result

echo ; echo