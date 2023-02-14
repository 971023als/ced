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


# 백업 디렉터리 경로 정의
BACKUP_DIR="/backup_invalid_owners"

# 잘못된 소유자가 있는 파일 또는 디렉터리 백업
mkdir -p "$BACKUP_DIR"
if find /root/ -nouser -print0 2>/dev/null | xargs -0 tar -czf "$BACKUP_DIR/invalid_owners_backup.tar.gz"; then
 OK "잘못된 소유자가 있는 파일 또는 디렉터리 백업 성공"
else
  INFO "잘못된 소유자가 있는 파일 또는 디렉터리를 백업하지 못했습니다."
fi
#--------------------------------------------------------------

BACKUP_DIR="/backup_invalid_owners"

# 잘못된 소유자가 있는 파일 또는 디렉터리 복원
if tar -xzf "$BACKUP_DIR/invalid_owners_backup.tar.gz" -C /; then
  OK "잘못된 소유자가 있는 파일 또는 디렉터리를 성공적으로 복원했습니다."
else
  INFO "잘못된 소유자가 있는 파일 또는 디렉터리를 복원하지 못함"
fi

# 백업 디렉터리 정리
if rm -rf "$BACKUP_DIR"; then
  INFO "백업 디렉터리를 성공적으로 정리했습니다"
else
  INFO "백업 디렉터리를 정리하지 못했습니다"
fi

cat $result

echo ; echo