#!/bin/bash

. function.sh

BAR

CODE [U-31] 스팸 메일 릴레이 제한		

cat << EOF >> $result

[양호]: SMTP 서비스를 사용하지 않거나 릴레이 제한이 설정되어 있는 경우

[취약]: SMTP 서비스를 사용하며 릴레이 제한이 설정되어 있지 않은 경우

EOF

BAR

# Backup the original file
cp /etc/mail/sendmail.cf /etc/mail/sendmail.cf.bak

# Specify file path
file="/etc/mail/sendmail.cf"

# Specify the original line
line="R$* $#error $@ 5.7.1 $: \"550 Relaying denied\""

# Add annotations to the original line
sed -i "s/$line/#&/" $file

# Verify that the line has been restored
grep "$line" $file



cat $result

echo ; echo
