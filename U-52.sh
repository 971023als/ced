#!/bin/bash

 

. function.sh

 

TMP2=$(mktemp)

TMP3=$(mktemp)

> $TMP2

> $TMP3

 

BAR

CODE [U-52] 동일한 UID 금지

cat << EOF >> $result

양호: 동일한 UID로 설정된 사용자 계정이 존재하지 않는 경우

취약: 동일한 UID로 설정된 사용자 계정이 존재하는 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1


# Store the original UIDs and username pairs
TMP3=$(mktemp)
awk -F: '{print $1 ":" $3}' "/etc/passwd" > $TMP3

# Run the previous script
./U-52.sh

# Check if the previous script has caused any problems
if [ "$?" -ne 0 ]; then
  # Revert the changes made to the user accounts
  while read -r line; do
    USER=$(echo "$line" | cut -d: -f1)
    UID=$(echo "$line" | cut -d: -f2)
    sudo usermod -u "$UID" "$USER"
  done < "$TMP3"
  echo "Changes have been successfully rolled back."
else
  # Remove temporary files
  sudo rm $TMP3
  echo "No problems detected, temporary files have been removed."
fi



 

cat $result

echo ; echo
