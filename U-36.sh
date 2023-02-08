#!/bin/bash

. function.sh

BAR

CODE [U-36] 웹서비스 웹 프로세스 권한 제한

cat << EOF >> $result

[양호]: Apache 데몬이 root 권한으로 구동되지 않는 경우

[취약]: Apache 데몬이 root 권한으로 구동되는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# Replace [Apache_home], [username], and [groupname] with appropriate original values
APACHE_CONF_FILE=/etc/httpd/conf/httpd.conf
USERNAME=root
GROUPNAME=root

# Replace user and group rows with original values
sed -i "s/User.*/User $USERNAME/g" $APACHE_CONF_FILE
sed -i "s/Group.*/Group $GROUPNAME/g" $APACHE_CONF_FILE


cat $result

echo ; echo