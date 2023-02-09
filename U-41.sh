#!/bin/bash

. function.sh

BAR

CODE [U-41] 웹서비스 영역의 분리

cat << EOF >> $result

[양호]: DocumentRoot를 별도의 디렉터리로 지정한 경우

[취약]: DocumentRoot를 기본 디렉터리로 지정한 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# Defining Apache Configuration Files
file="/etc/httpd/conf/httpd.conf"

# Replace DocumentRoot value with the original path
sed -i 's#DocumentRoot /home/centos/newphp/#DocumentRoot /var/www/html#g' $file


cat $result

echo ; echo