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

# Start the DNS service
/usr/sbin/named

# Check if the DNS service is running
if ps -ef | grep named &> /dev/null; then
  OK "DNS service has been successfully restored."
else
  WARN "DNS service has not been restored."
fi


cat $result

echo ; echo