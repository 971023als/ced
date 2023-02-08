#!/bin/bash

. function.sh

BAR

CODE [U-33]  DNS 보안 버전 패치 '확인 필요'

cat << EOF >> $result
[양호]: DNS 서비스를 사용하지 않거나 주기적으로 패치를 관리하고 있는 경우

[취약]: DNS 서비스를 사용하며 주기적으로 패치를 관리하고 있지 않는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# Start the named service
named &

# Confirm the named service is running
PID=$(ps -ef | grep named | awk '{print $2}')
if [ -z "$PID" ]; then
  echo "The named service could not be started."
else
  echo "The named service has been started with PID: $PID"
fi

 



cat $result

echo ; echo