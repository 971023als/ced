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



for user in $(awk -F: '{ if ($3 >= 1000 && $3 <= 60000) print $1}' /etc/passwd); do
  if [ -d /home/$user ]; then
    usermod -d /$user $user
  fi
done

echo "The home directories for user accounts have been restored to their original state."








cat $result

echo ; echo 


 
