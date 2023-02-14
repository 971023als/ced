#!/bin/bash

 

. function.sh


BAR

CODE [U-68] 로그온 시 경고 메시지 제공

cat << EOF >> $result
[양호]: 서버 및 Telnet 서비스에 로그온 메시지가 설정되어 있는 경우
[취약]: 서버 및 Telnet 서비스에 로그온 메시지가 설정되어 있지 않은 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

files=("/etc/motd" "/etc/issue.net" "/etc/vsftpd/vsftpd.conf" "/etc/mail/sendmail.cf" "/etc/named.conf")

for file in "${files[@]}"; do
  if [ -e "$file" ]; then
    original_contents=`cat "$file"`
    echo "$original_contents" > "$file"
    if [ $? -eq 0 ]; then
      OK "파일 $file 의 원래 상태가 복구되었습니다."
    else
      WARN "파일 $file의 원래 상태를 복구하지 못했음을 나타냅니다."
    fi
  else
    INFO "$file  파일이 존재하지 않습니다. 건너뜁니다.."
  fi
done

cat $result

echo ; echo