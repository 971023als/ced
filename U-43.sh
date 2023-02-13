#!/bin/bash

. function.sh

BAR

CODE [U-43] 로그의 정기적 검토 및 보고

cat << EOF >> $result
[양호]: 접속기록 등의 보안 로그, 응용 프로그램 및 시스템 로그 기록에 대해 정기적으로 검토, 분석, 리포트 작성 및 보고 등의 조치가 이루어지는 경우
[취약]: 위 로그 기록에 대해 정기적으로 검토, 분석, 리포트 작성 및 보고 등의 조치가 이루어 지지 않는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Define the original state variables
ORIG_UTMP="/var/log/utmp.original"
ORIG_XFERLOG="/var/log/xferlog.original"

# Check if the original state exists
if [ -e "$ORIG_UTMP" ] && [ -e "$ORIG_XFERLOG" ]; then
  # Restore the original state of /var/log/utmp
  rm -f /var/log/utmp
  mv "$ORIG_UTMP" /var/log/utmp

  # Restore the original state of /var/log/xferlog
  rm -f /var/log/xferlog
  mv "$ORIG_XFERLOG" /var/log/xferlog

  OK "Original state restored."
else
  WARN "Original state not found. Nothing to restore."
fi

cat $result

echo ; echo