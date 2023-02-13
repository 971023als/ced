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

# Function to restore the original state
restore_original_state() {
  # Backup the current rsyslog.conf file
  cp /etc/rsyslog.conf /etc/rsyslog.conf.bak

  # Replace the current rsyslog.conf file with the backup
  mv /etc/rsyslog.conf.bak /etc/rsyslog.conf
}

# Check if the script was executed with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or with sudo."
fi

# Try to restore the original state
restore_original_state

# Check if the restoration was successful
diff=$(diff /etc/rsyslog.conf /etc/rsyslog.conf.bak)

if [ -n "$diff" ]; then
  echo "Recovery failed."
else
  echo "Recovery successful."
fi


cat $result

echo ; echo