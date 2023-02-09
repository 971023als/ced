#!/bin/bash


. function.sh


BAR

CODE [U-71] Apache 웹서비스 정보 숨김

cat << EOF >> $result

[양호]: ServerTokens Prod, ServerSignature Off로 설정되어있는 경우

[취약]: ServerTokens Prod, ServerSignature Off로 설정되어있지 않은 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1 

# 원본 httpd.conf 백업
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak

# 원래 서버 토큰 복원 지시문
grep -q "^ServerTokens" /etc/httpd/conf/httpd.conf.bak
if [ $? -eq 0 ]; then
  sed -i 's/^ServerTokens.*/ServerTokens /' /etc/httpd/conf/httpd.conf
else
  sed -i '/^ServerTokens.*/d' /etc/httpd/conf/httpd.conf
fi

# 원래 서버 서명 지시문 복원
grep -q "^ServerSignature" /etc/httpd/conf/httpd.conf.bak
if [ $? -eq 0 ]; then
  sed -i 's/^ServerSignature.*/ServerSignature /' /etc/httpd/conf/httpd.conf
else
  sed -i '/^ServerSignature.*/d' /etc/httpd/conf/httpd.conf
fi



cat $result

echo ; echo 