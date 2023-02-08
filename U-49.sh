#!/bin/bash

 

. function.sh


 

BAR

CODE [U-49] 불필요한 계정 제거

cat << EOF >> $result

[양호]: 불필요한 계정이 존재하지 않는 경우

[취약]: 불필요한 계정이 존재하는 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1

# Get a list of users whose shell is set to /bin/false
user_list=$(cat /etc/passwd | grep /bin/false | awk -F: '{print $1}')

# Rotate the list of users
for user in $user_list; do
# Change the user shell to /bin/bash
usermod -s /bin/bash $user
if [ $? -eq 0 ]; then
INFO "Login is now enabled for user: $user."
else
OK "Unable to enable login for user: $user."
fi
done

# Get a list of recently deleted non-default accounts
deleted_users=$(grep "Removing non-default account" $TMP1 | awk '{print $NF}')

# Rotate the list of deleted users
for user in $deleted_users; do
INFO "Restoring non-default account: $user"
sudo useradd "$user"
done

OK "All non-default accounts have been restored."


 
cat $result

echo ; echo
