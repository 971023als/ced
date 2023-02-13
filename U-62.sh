#!/bin/bash

. function.sh

BAR

CODE [U-62] ftp 계정 shell 제한

cat << EOF >> $result
[양호]: ftp 계정에 /bin/false 쉘이 부여되어 있는 경우
[취약]: ftp 계정에 /bin/false 쉘이 부여되지 않 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

# Get the original entry of the FTP account from the /etc/passwd
original_entry=$(grep -w "^ftp" /etc/passwd.bak)

# Write the original entry to the /etc/passwd file
sudo sed -i "s#^ftp:.*#$original_entry#" /etc/passwd

# Check the shell of the FTP account to see the changes
ftp_shell=$(grep "^ftp:" /etc/passwd | awk -F: '{print $7}')
if [ "$ftp_shell" == "$(echo $original_entry | awk -F: '{print $7}')" ]; then
OK "The shell of the FTP account is set to its original value."
else
INFO "The shell of the FTP account cannot be set to its original value."
fi

cat $result

echo ; echo