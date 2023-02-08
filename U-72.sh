#!/bin/bash

 

. function.sh

 

BAR

CODE [U-72] 정책에 따른 시스템 로깅 설정

cat << EOF >> $result

[양호]: 로그 기록 정책이 정책에 따라 설정되어 수립되어 있는 경우

[취약]: 로그 기록 정책이 정책에 따라 설정되어 수립되어 있지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1 



# # Stop the rsyslog service
service rsyslog stop

# # Restore the original file
mv /etc/rsyslog.conf.bak /etc/rsyslog.conf

# # Restart the rsyslog service
service rsyslog restart


cat $result

echo ; echo 

 
