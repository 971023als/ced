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

# Backup log files
cp /var/log/wtmp /var/log/btmp /var/log/lastlog /var/log/xferlog ~/backup/logs/

# Backup configuration files
cp function.sh ~/backup/config/

# If there is a problem after running the script, restore the log files and configuration files from the backup directory
cp ~/backup/logs/* /var/log/
cp ~/backup/config/function.sh .





cat $result

echo ; echo