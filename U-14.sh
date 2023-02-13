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


# Backup files
cp $HOME/.bashrc $HOME/.bashrc.bak
cp $HOME/.bash_profile $HOME/.bash_profile.bak
cp $HOME/.bash_aliases $HOME/.bash_aliases.bak

files=( "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.bash_aliases" )

for file in "${files[@]}"; do
  if [ -e "$file" ]; then
    chmod o-w "$file"
    if [ $? -eq 0 ]; then
      OK "$file 에서 다른 사용자에 대한 쓰기 권한이 제거되었습니다."
    else
      WARN "$file 에서 다른 사용자에 대한 쓰기 권한을 제거하지 못했습니다."
    fi
  fi
done



cat $result

echo ; echo
