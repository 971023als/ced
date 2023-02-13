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

# Define the Apache Configuration File
APACHE_CONF_FILE=/etc/httpd/conf/httpd.conf

# Get the original values of the User and Group rows
ORIGINAL_USER=$(grep "User" $APACHE_CONF_FILE | awk '{print $2}')
ORIGINAL_GROUP=$(grep "Group" $APACHE_CONF_FILE | awk '{print $2}')

# Replace the current User and Group rows with the original values
sed -i "s/User.*/User $ORIGINAL_USER/g" $APACHE_CONF_FILE
sed -i "s/Group.*/Group $ORIGINAL_GROUP/g" $APACHE_CONF_FILE

# Restart Apache service
sudo systemctl restart httpd

# Check if Apache service is running
if systemctl is-active --quiet httpd; then
  OK "Apache service has been successfully restored."
else
  WARN "Apache service has not been restored."
fi


cat $result

echo ; echo