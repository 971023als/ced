#!/bin/bash

 

. function.sh

 

BAR

CODE [U-65] at 파일 소유자 및 권한 설정

cat << EOF >> $result
[양호]: at 접근제어 파일의 소유자가 root이고, 권한이 640 이하인 경우
[취약]: at 접근제어 파일의 소유자가 root가 아니거나, 권한이 640 이하가 아닌 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

# Restore original permissions for /usr/bin/at
chmod 755 /usr/bin/at

# Restore original owner and permissions for /etc/at.deny
chown root:root /etc/at.deny
chmod 644 /etc/at.deny

# Check if restoration was successful
if [[ "$(stat -c %a /usr/bin/at)" == "755" && "$(stat -c %U /usr/bin/at)" == "root" && "$(stat -c %a /etc/at.deny)" == "644" && "$(stat -c %U /etc/at.deny)" == "root" ]]; then
  OK "복원이 성공했습니다."
else
  WARN "복원이 성공하지 않았음을 나타냅니다."
fi

cat $result

echo ; echo