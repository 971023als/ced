#!/bin/bash

 

. function.sh

 

BAR

CODE [U-70] expn, vrfy 명령어 제한

cat << EOF >> $result

[양호]: SMTP 서비스 미사용 또는, noexpn, novrfy 옵션이 설정되어 있는 경우

[취약]: SMTP 서비스 사용하고, noexpn, novrfy 옵션이 설정되어 있지 않는 경우

EOF

BAR

# 송신 메일 초기화 스크립트 복원
mv /etc/rc2.d/S88sendmail_bak /etc/rc2.d/S88sendmail

# 메일 보내기 서비스 시작
service sendmail restart   

INFO "백업 완료"

cat $result

echo ; echo 
