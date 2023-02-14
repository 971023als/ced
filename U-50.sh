#!/bin/bash

. function.sh

BAR

CODE [U-50] 관리자 그룹에 최소한의 계정 포함

cat << EOF >> $result
[양호]: 관리자 그룹에 불필요한 계정이 등록되어 있지 않은 경우
[취약]: 관리자 그룹에 불필요한 계정이 등록되어 있는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

# /etc/passwd 백업 파일 생성
cp /etc/passwd.bak /etc/passwd

# 백업 파일이 있는지 확인하십시오
if [ -f "/path/to/backup/etc_passwd_backup" ]; then
  # /etc/passwd 파일의 백업 복원
  sudo cp /path/to/backup/etc_passwd_backup /etc/passwd
  # /etc/passwd 파일에 대한 올바른 사용 권한 설정
  sudo chmod 644 /etc/passwd
  sudo chown root:root /etc/passwd
  OK "시스템이 성공적으로 원래 상태로 복원되었습니다."
else
  WARN "백업 파일을 찾을 수 없습니다. 시스템을 복원할 수 없습니다."
fi

cat $result

echo ; echo