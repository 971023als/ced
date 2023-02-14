#!/bin/bash

. function.sh

BAR

CODE [U-06] 파일 및 디렉터리 소유자 설정 @@su 말고 sudo su 해야 함 @@

cat << EOF >> $result

[양호]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하지 않는 경우

[취약]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# 백업 디렉토리(존재하지 않는 경우) 생성
if [ ! -d "$backup_dir" ]; then
    mkdir -p $backup_dir
fi

# 잘못된 소유자가 있는 파일 찾기
invalid_owner_files=$(find /root/ -nouser -print 2>/dev/null)
if [ -f "$invalid_owner_files" ]; then
  if [ -z "$invalid_owner_files" ]; then
      WARN "백업할 파일이 없습니다."
  else
    cp -R $invalid_owner_files $backup_dir
    OK "백업이 완료되었습니다."
  fi
else
  INFO "$invalid_owner_files 을 찾을 수 없습니다"
fi

# 잘못된 소유자가 있는 백업 파일 찾기
backup_files=$(find $backup_dir -type f -o -type d)
if [ -f "$backup_files" ]; then
  if [ -z "$backup_files" ]; then
    INFO "백업된 파일을 찾을 수 없습니다."
  else
    cp -R $backup_files /root/
    OK "복원이 완료되었습니다."
  fi
else
  INFO "$backup_files 을 찾을 수 없습니다"
fi

cat $result

echo ; echo