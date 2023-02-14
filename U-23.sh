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
    OK "echo 서비스 파일이 복원되었습니다.."
else
    INFO "echo 서비스 파일을 찾을 수 없습니다."
fi

# Check if discard service file exists and restore its original state
if [ -f /etc/xinetd.d/discard ]; then
    rm /etc/xinetd.d/discard
    OK "discard 서비스 파일이 복원되었습니다."
else
    INFO "discard 서비스 파일을 찾을 수 없습니다."
fi

# Check if daytime service file exists and restore its original state
if [ -f /etc/xinetd.d/daytime ]; then
    rm /etc/xinetd.d/daytime
    OK "daytime 서비스 파일이 복원되었습니다."
else
    INFO "daytime 서비스 파일을 찾을 수 없습니다."
fi

# Check if chargen service file exists and restore its original state
if [ -f /etc/xinetd.d/chargen ]; then
    rm /etc/xinetd.d/chargen
    OK "chargen 서비스 파일이 복원되었습니다."
else
    INFO "chargen 서비스 파일을 찾을 수 없습니다."
fi


cat $result

echo ; echo