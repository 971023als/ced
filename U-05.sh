#!/bin/bash

. function.sh

BAR

CODE [U-05] root홈, 패스 디렉터리 권한 및 패스 설정

cat << EOF >> $result
[양호]: PATH 환경변수에 “.” 이 맨 앞이나 중간에 포함되지 않은 경우
[취약]: PATH 환경변수에 “.” 이 맨 앞이나 중간에 포함되어 있는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Restore original /etc/profile file
cp /etc/profile.bak /etc/profile

# Restore original ~/.profile file
cp ~/.profile.bak ~/.profile

# Reload environment variables
source ~/.profile
source /etc/profile

# Check if PATH environment variable still contains "."
if [[ "$PATH" == *"."* ]]; then
  OK "PATH 환경 변수가 여전히 "."(현재 디렉토리)를 포함하고 있음"
else
  WARN "PATH 환경 변수에서 "."(현재 디렉토리)가 더 이상 포함되지 않았음"
fi



cat $result

echo ; echo