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

# 셸이 /bin/false로 설정된 사용자 목록 가져오기
user_list=$(cat /etc/passwd | grep /bin/false | awk -F: '{print $1}')

# 사용자 목록
for user in $user_list; do
# 사용자 셸을 /bin/bash로 변경합니다
sudo usermod -s /bin/bash $user
if [ $? -eq 0 ]; then
    INFO "이제 사용자: $user 에 대해 로그인이 활성화되었습니다."
else
    OK "사용자: $user 에 대한 로그인을 활성화할 수 없습니다."
fi
done

# 최근에 삭제된 기본 계정이 아닌 계정 목록 가져오기
deleted_users=$(grep "Removing non-default account" $TMP1 | awk '{print $NF}')

# 삭제된 사용자 목록 회전
for user in $deleted_users; do
    INFO "기본이 아닌 계정을 복원하는 중: $user"
sudo useradd "$user"
done

OK "기본값이 아닌 모든 계정이 복원되었습니다."

 
cat $result

echo ; echo