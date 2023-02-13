#!/bin/bash

. function.sh

BAR

CODE [U-14] 사용자, 시스템 시작파일 및 환경파일 소유자 및 권한 설정		

cat << EOF >> $result
[양호]: 홈 디렉터리 환경변수 파일 소유자가 root 또는, 해당 계정으로 지정되
어 있고, 홈 디렉터리 환경변수 파일에 root와 소유자만 쓰기 권한이 부여
된 경우
[취약]: 홈 디렉터리 환경변수 파일 소유자가 root 또는, 해당 계정으로 지정되
지 않고, 홈 디렉터리 환경변수 파일에 root와 소유자 외에 쓰기 권한이 
부여된 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

files=(".profile" ".kshrc" ".cshrc" ".bashrc" ".bash_profile" ".login" ".exrc" ".netrc")

for file in "${files[@]}"; do
if [ ! -f $file ]; then
INFO "$file does not exist."
continue
fi

original_owner=$(stat -c '%U' $file)
original_permission=$(stat -c '%a' $file)

current_owner=$(stat -c '%U' $file)
current_permission=$(stat -c '%a' $file)

if [ "$original_owner" != "$current_owner" ] || [ "$original_permission" != "$current_permission" ]; then
echo "Recovering $file to its original state..."
chown $original_owner $file
chmod $original_permission $file
OK "$file was recovered."
else
WARN "$file was not recovered."
fi
done



cat $result

echo ; echo