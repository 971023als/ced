#!/bin/bash

. function.sh

BAR

CODE [U-22] crond 파일 소유자 및 권한 설정

cat << EOF >> $result
[양호]: crontab 명령어 일반사용자 금지 및 cron 관련 파일 640 이하인 경우
[취약]: crontab 명령어 일반사용자 사용가능하거나, crond 관련 파일 640 이상인 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

sudo chown root:root /etc/crontab
sudo chmod 644 /etc/crontab

sudo chown root:root /etc/cron.hourly
sudo chmod 755 /etc/cron.hourly

sudo chown root:root /etc/cron.daily
sudo chmod 755 /etc/cron.daily

sudo chown root:root /etc/cron.weekly
sudo chmod 755 /etc/cron.weekly

sudo chown root:root /etc/cron.monthly
sudo chmod 755 /etc/cron.monthly

sudo chown root:root /etc/cron.allow
sudo chmod 644 /etc/cron.allow

sudo chown root:root /etc/cron.deny
sudo chmod 644 /etc/cron.deny

sudo chown root:crontab /var/spool/cron*
sudo chmod 770 /var/spool/cron*

sudo chown root:crontab /var/spool/cron/crontabs/
sudo chmod 700 /var/spool/cron/crontabs/

# Check if the original state has been restored
if [ $(stat -c "%a" /etc/crontab) -eq 644 ] &&
   [ $(stat -c "%a" /etc/cron.hourly) -eq 755 ] &&
   [ $(stat -c "%a" /etc/cron.daily) -eq 755 ] &&
   [ $(stat -c "%a" /etc/cron.weekly) -eq 755 ] &&
   [ $(stat -c "%a" /etc/cron.monthly) -eq 755 ] &&
   [ $(stat -c "%a" /etc/cron.allow) -eq 644 ] &&
   [ $(stat -c "%a" /etc/cron.deny) -eq 644 ] &&
   [ $(stat -c "%a" /var/spool/cron*) -eq 770 ] &&
   [ $(stat -c "%a" /var/spool/cron/crontabs/) -eq 700 ]; then
   OK "원래 상태를 복원"
else
   WARN "복원하지 못함"
fi


cat $result

echo ; echo