#!/bin/bash

 

. function.sh

 

 

BAR

CODE [U-59] 숨겨진 파일 및 디렉터리 검색 및 제거

cat << EOF >> $result

[양호]: 디렉터리 내 숨겨진 파일을 확인하여, 불필요한 파일 삭제를 완료한 경우

[취약]: 디렉터리 내 숨겨진 파일을 확인하지 않고, 불필요한 파일을 방치한 경우

EOF

BAR

# 변수 설정
backup_dir="/backups/"
source_dir="/home/user/"

# 백업 디렉토리(존재하지 않는 경우) 생성
if [ ! -d "$backup_dir" ]; then
    mkdir "$backup_dir"
fi

# 숨겨진 파일 백업 (커널 밑에 있는 파일은 제외)
find / -type f -name ".*" ! -path "/run/user/1000/gvfs/*" ! -path "/sys/*" ! -path "/proc/*" -exec cp --parents {} "$backup_dir" \;

# 숨겨진 디렉터리 백업 (커널 밑에 있는 디렉터리는 제외)
find / -type d -name ".*" ! -path "/run/user/1000/gvfs/*" ! -path "/sys/*" ! -path "/proc/*" -exec cp -r --parents {} "$backup_dir" \;


#--------------------------------------------------------------------------------------------------

# 변수 설정
backup_dir="/backups/"
source_dir="/home/user/"

# 숨겨진 파일 및 디렉터리 복구
rsync -a --delete "$backup_dir" "$source_dir"

INFO "숨겨진 디렉토리 및 파일을 복구 완료"

cat $result

echo ; echo 

 
