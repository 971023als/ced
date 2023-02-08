#!/bin/bash

 

 

. function.sh

 
 TMP1=`SCRIPTNAME`.log

> $TMP1

BAR

CODE [U-04] 패스워드 파일 보호

cat << EOF >> $result

[양호]: 쉐도우 패스워드를 사용하거나, 패스워드를 암호화하여 저장하는 경우

[취약]: 쉐도우 패스워드를 사용하지 않고, 패스워드를 암호화하여 저장하지 않는 경우

EOF

BAR


# Backup the shadow password file
cp /etc/shadow /etc/shadow.bak

# Restore shadow password file to original state
cp /etc/shadow.bak /etc/shadow

# Verify the contents of the shadow password file
cat /etc/shadow

echo "Shadow password file restored successfully."


 

 

cat $result

echo ; echo
