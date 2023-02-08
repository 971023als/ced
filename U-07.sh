#!/bin/bash

. function.sh

BAR

CODE [U-07] /etc/passwd 파일 소유자 및 권한 설정	

cat << EOF >> $result

[양호]: /etc/passwd 파일의 소유자가 root이고, 권한이 644 이하인 경우

[취약]: /etc/passwd 파일의 소유자가 root가 아니거나, 권한이 644 이하가 아닌
경우

EOF

BAR


# Save the original owner and permissions of /etc/passwd to a temporary file
stat -c "%U %G %a" /etc/passwd > /tmp/original_passwd_state

# Check if the temporary file exists
if [ -f "/tmp/original_passwd_state" ]; then
  # Read the first line of the temporary file
  original_state=$(head -n 1 /tmp/original_passwd_state)

  # Split the line into an array using space as a separator
  arr=($original_state)

  # The first element of the array is the original owner
  owner=${arr[0]}
  # The second element of the array is the original group
  group=${arr[1]}
  # The third element of the array is the original permission
  permission=${arr[2]}

  # Restore the original owner, group, and permission of /etc/passwd
  sudo chown $owner:$group /etc/passwd
  sudo chmod $permission /etc/passwd

  # Remove the temporary file
  rm /tmp/original_passwd_state
else
  # The temporary file does not exist, display an error message
  echo "Error: Temporary file not found, unable to restore the original state of /etc/passwd"
fi


cat $result

echo ; echo