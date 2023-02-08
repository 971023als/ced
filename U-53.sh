#!/bin/bash

 

. function.sh


TMP2=/tmp/tmp1

> $TMP2

 

BAR

CODE [U-53] 사용자 shell 점검

cat << EOF >> $result

[취약]: 로그인이 필요하지 않은 계정에 /bin/false(nologin) 쉘이 부여되어 있는 경우

[양호]: 로그인이 필요하지 않은 계정에 /bin/false(nologin) 쉘이 부여되지 않은 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1


# Read the original shells of the users from the log file
while read -r line; do
  user=$(echo "$line" | awk '{print $1}')
  original_shell=$(echo "$line" | awk '{print $3}')

  # Restore the original shell of the user
  sudo usermod -s "$original_shell" "$user"
  INFO "Restored user $user shell to $original_shell"
done < "$TMP1"




 

cat $result

echo ; echo
