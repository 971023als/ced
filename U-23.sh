#!/bin/bash

. function.sh

BAR

CODE [U-23] DoS 공격에 취약한 서비스 비활성화		

cat << EOF >> $result
[양호]: 사용하지 않는 DoS 공격에 취약한 서비스가 비활성화 된 경우
[취약]: 사용하지 않는 DoS 공격에 취약한 서비스가 활성화 된 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

echo "Restoring original state of DoS attack vulnerable services..."

# Check if echo service file exists and restore its original state
if [ -f /etc/xinetd.d/echo ]; then
    rm /etc/xinetd.d/echo
    OK "echo service file has been restored."
else
    WARN "echo service file was not found."
fi

# Check if discard service file exists and restore its original state
if [ -f /etc/xinetd.d/discard ]; then
    rm /etc/xinetd.d/discard
    OK "discard service file has been restored."
else
    WARN "discard service file was not found."
fi

# Check if daytime service file exists and restore its original state
if [ -f /etc/xinetd.d/daytime ]; then
    rm /etc/xinetd.d/daytime
    OK "daytime service file has been restored."
else
    WARN "daytime service file was not found."
fi

# Check if chargen service file exists and restore its original state
if [ -f /etc/xinetd.d/chargen ]; then
    rm /etc/xinetd.d/chargen
    OK "chargen service file has been restored."
else
    WARN "chargen service file was not found."
fi


cat $result

echo ; echo