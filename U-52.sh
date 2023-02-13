#!/bin/bash

. function.sh

BAR

CODE [U-52] 동일한 UID 금지

cat << EOF >> $result
양호: 동일한 UID로 설정된 사용자 계정이 존재하지 않는 경우
취약: 동일한 UID로 설정된 사용자 계정이 존재하는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

# Files containing user accounts
PASSWD="/etc/passwd"

# Temporary file to store the original UIDs of users
TMP_ORIGINAL=$(mktemp)

# Save the original UIDs of users to a temporary file
awk -F: '{print $1 ":" $3}' "$PASSWD" > $TMP_ORIGINAL

# Check if the previous script has been executed
if [ -f $TMP1 ]; then
# Temporary file to store the changed UIDs of users
TMP_CHANGED=$(mktemp)

# Save the changed UIDs of users to a temporary file
awk -F: '{print $1 ":" $3}' "$PASSWD" > $TMP_CHANGED

# Store the changed UIDs of users in an array
CHANGED_UIDS=($(cut -d: -f2 $TMP_CHANGED))

# Loop through the changed UIDs of users
for uid in "${CHANGED_UID[@]}"; do
# Get the user with the changed UID
CHANGED_USER=$(grep ":$uid" $TMP_CHANGED | cut -d: -f1)

# Get the original UID of the user
ORIGINAL_UID=$(grep "^$CHANGED_USER:" $TMP_ORIGINAL | awk -F: '{print $2}')

# Check if the UID of the user has been changed
if [ $uid -ne $ORIGINAL_UID ]; then
# Change the UID of the user back to its original value
usermod -u $ORIGINAL_UID $CHANGED_USER

# Print Results
INFO "$CHANGED_USER's UID restored to $ORIGINAL_UID"
fi
done

# Remove temporary files
rm $TMP_ORIGINAL $TMP_CHANGED

else
INFO "Previous script has not been executed."
fi


cat $result

echo ; echo