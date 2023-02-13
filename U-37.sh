#!/bin/bash

. function.sh

BAR

CODE [U-37] 웹서비스 상위 디렉토리 접근 금지

cat << EOF >> $result
[양호]: 상위 디렉터리에 이동제한을 설정한 경우
[취약]: 상위 디렉터리에 이동제한을 설정하지 않은 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Defining Apache Configuration Files
file="/etc/httpd/conf/httpd.conf"

if [ -f "$file" ]; then
# # Replace "AllowOverride AuthConfig" with "AllowOverride None"
sed -i 's/AllowOverride AuthConfig/AllowOverride None/g' $file

# Check for changes
if grep -q "AllowOverride None" $file; then
OK "AllowOverride AuthConfig was replaced with AllowOverride None."
else
WARN "AllowOverride AuthConfig could not be replaced with AllowOverride None."
fi
fi

# Restart the httpd daemon to apply configuration changes
sudo service httpd restart



cat $result

echo ; echo