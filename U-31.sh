#!/bin/bash

. function.sh

BAR

CODE [U-31] 스팸 메일 릴레이 제한		

cat << EOF >> $result

[양호]: SMTP 서비스를 사용하지 않거나 릴레이 제한이 설정되어 있는 경우

[취약]: SMTP 서비스를 사용하며 릴레이 제한이 설정되어 있지 않은 경우

EOF

BAR

# Specify file path
file="/etc/mail/sendmail.cf"

# Specify which lines to annotate
line="R$* $#error $@ 5.7.1 $: \"550 Relaying denied\""

# Add annotations back to the lines
sed -i "s/^R/$#R/" $file

# Verify that the line has been modified
if grep "$line" $file; then
  OK "The original state has not been recovered"
else
  WARN "The original state has been successfully recovered"
fi




cat $result

echo ; echo
