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



files=( "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.bash_aliases" )

# Restore original permissions for specified files
restore_permissions() {
filename=$1
original_permission=$(stat -c "%a" "$filename")
sudo chmod "$original_permission" "$filename"
INFO "Restored original permissions for $filename"
}

for file in "${files[@]}"; do
if [ -e "$file" ]; then
restore_permissions "$file"
fi
done



cat $result

echo ; echo
