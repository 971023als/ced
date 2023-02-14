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


# 백업 스크립트
backup_file="/tmp/invalid_owner_files_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
tar -czvf $backup_file /root/ --owner=root --group=root --mtime='UTC' --atime-preserve=system --selinux --acls --xattrs

# -----------------------------------------------------------------------------------------

# 스크립트 복원
restore_file=$(ls -1t /tmp/invalid_owner_files*.tar.gz 2>/dev/null | head -n1)
if [ -f "$backup_file" ]; then
  if [ -z "$restore_file" ]; then
      WARN "백업 파일을 찾을 수 없습니다."
  else
    OK "$restore_file에서 복원 중"
    tar -xzvf $restore_file -C /
  fi
else
  INFO "$file 을 찾을 수 없습니다"
fi

cat $result

echo ; echo