#!/bin/bash

. function.sh

BAR

CODE [U-16] /dev에 존재하지 않는 device 파일 점검

cat << EOF >> $result  

[양호]: dev에 대한 파일 점검 후 존재하지 않은 device 파일을 제거한 경우

[취약]: dev에 대한 파일 미점검, 또는, 존재하지 않은 device 파일을 방치한 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# 백업 디렉터리 정의
backup_dir="/dev_backup"

# 현재 /dev 디렉토리 제거
rm -rf /dev

# 제거가 성공적이었는지 확인하십시오
if [ $? -eq 0 ]; then
  OK "/dev 디렉토리가 제거되었습니다."
else
  INFO "/dev 디렉토리 제거 실패"
fi

# 백업 디렉토리를 /dev에 복사합니다
sudo cp -R $backup_dir /dev

# 복사가 성공했는지 확인합니다
if [ $? -eq 0 ]; then
  OK "$backup_dir 디렉토리가 /dev에 복사되었습니다."
else
  WARN "$backup_dir 디렉토리 복사 실패"
fi
 
cat $result

echo ; echo

