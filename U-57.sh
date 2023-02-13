#!/bin/bash

. function.sh

BAR

CODE [U-57] 홈 디렉터리 소유자 및 권한

cat << EOF >> $result
[양호]: 홈 디렉터리 소유자가 해당 계정이고, 일반 사용자 쓰기 권한이 제거된 경우
[취약]: 홈 디렉터리 소유자가 해당 계정이 아니고, 일반 사용자 쓰기 권한이 부여된 경우 
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1  

# Read /etc/passwd file and extract home directory
output=$(cat /etc/passwd | awk -F ':' '{print $6}')

# Split the output into arrays
arr=($output)

# Repeat the array to verify each home directory
for line in "${arr[@]}"
do
original_permissions=$(stat -c "%a" $line)
original_owner=$(stat -c "%U" $line)
original_group=$(stat -c "%G" $line)

permissions=$(ls -ld $line | awk '{print $1}')
owner=$(ls -ld $line | awk '{print $3}')
group=$(ls -ld $line | awk '{print $4}')

if [[ $permissions != *"$original_permissions"* ]] || [[ $owner != *"$original_owner"* ]] || [[ $group != *"$original_group"* ]]; then
INFO "Restoring original ownership and permissions: $line"
sudo chown $original_owner:$original_group $line
sudo chmod $original_permissions $line

if [[ $permissions == *"$original_permissions"* ]] && [[ $owner == *"$original_owner"* ]] && [[ $group == *"$original_group"* ]]; then
    OK "Recovered: $line"
else
    WARN "Not recovered: $line"
fi
fi
done

cat $result

echo ; echo