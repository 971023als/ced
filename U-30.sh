#!/bin/bash

 

. function.sh

 
TMP1=`SCRIPTNAME`.log

> $TMP1
 
 

BAR

CODE [U-30] Sendmail 버전 점검

cat << EOF >> $result

[양호]: Sendmail 버전이 최신버전인 경우 

[취약]: Sendmail 버전이 최신버전이 아닌 경우

EOF

BAR


# Start Sendmail service
sudo service sendmail restart

# Check if the service is running
if [ $(systemctl is-active sendmail) == "active" ]; then
  echo "Sendmail service has been successfully restarted"
else
  echo "Error starting the Sendmail service"
fi







cat $result

echo ; echo
 
