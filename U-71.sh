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

TMP2=`SCRIPTNAME`_backup.log

cp "$filename" "$TMP2"

if [ -e "$TMP2" ]; then
  OK "복원 성공: $TMP2"
else
  WARN "복원 불가."
fi

# Replace "ServerTokens Prod" with "ServerTokens Full" in apache2.conf file
sed -i 's/ServerTokens Prod/ServerTokens Full/g' "$filename"

# Replace "ServerSignatureOff" with "ServerSignatureOn" in the apache2.conf file
sed -i 's/ServerSignature Off/ServerSignature On/g' "$filename"

# Verify that Server Tokens is set to "Full"
if ! grep -q "ServerTokens Full" "$filename"; then
echo "ServerTokens Full" >> "$filename"
fi

# Verify that Server Signature is set to "On"
if ! grep -q "ServerSignature On" "$filename"; then
echo "ServerSignature On" >> "$filename"
fi

if cmp -s "$filename" "$TMP2"; then
  OK "복구가 성공했습니다."
else
  WARN "복구가 실패했음을 나타냅니다."
fi



cat $result

echo ; echo