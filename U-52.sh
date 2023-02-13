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

# Check if the log file exists
if [ -f $TMP1 ]; then

# Read the log file and store the data in an array
LOG_DATA=($(cat $TMP1))

# Loop through the log data and restore the original state
for data in "${LOG_DATA[@]}"; do

# Split the log data into user and UID
USER=$(echo $data | awk -F: '{print $1}')
ORIG_UID=$(echo $data | awk -F: '{print $2}')

# Check if the user exists in the system
if id $USER >/dev/null 2>&1; then

# Change the user's UID to the original UID
usermod -u $ORIG_UID $USER

# Print the results
INFO "UID of $USER changed back to $ORIG_UID"
fi
done

# Remove the log file
rm $TMP1

# Print the result
OK "Original state has been successfully restored."
else
WARN "Log file does not exist, no changes were made to the system."
fi


cat $result

echo ; echo