#!/bin/bash

 

. function.sh
 

BAR

CODE [U-69] NFS 설정파일 접근권한

cat << EOF >> $result
[양호]: NFS 접근제어 설정파일의 소유자가 root 이고, 권한이 644 이하인 경우
[취약]: NFS 접근제어 설정파일의 소유자가 root 가 아니거나, 권한이 644 이하가 아닌 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

filename="/etc/exports"
original_owner=`ls -l $filename | awk '{print $3}'`
original_permissions=`stat -c %a $filename`

if [ $original_owner != "root" ] || [ $original_permissions -gt 644 ]; then
  chown $original_owner "$filename"
  chmod $original_permissions "$filename"
  if [ $? -eq 0 ]; then
    OK "원래 상태가 성공적으로 복구되었습니다."
  else
    WARN "원래 상태를 복구하지 못했음을 나타냅니다."
  fi
else
  INFO "이미 원래 상태의 파일이 있습니다.."
fi

cat $result

echo ; echo