#!/bin/bash

. function.sh

BAR

CODE [U-20] Anonymous FTP 비활성화

cat << EOF >> $result

[양호]: Anonymous FTP (익명 ftp) 접속을 차단한 경우

[취약]: Anonymous FTP (익명 ftp) 접속을 차단하지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  



# Restore the FTP user
sudo useradd ftp

# Set the path to the vsftpd.conf file
vsftpd_conf_file="/etc/vsftpd.conf"

# Verify that the vsftpd.conf file exists.
if [ -f $vsftpd_conf_file ]; then
  # Remove the line "anonymous_enable=NO" (if present)
  sed -i '/^anonymous_enable=NO/d' $vsftpd_conf_file
else
  # File not found
  INFO " $vsftpd_conf_file not found."
fi

# Restore the original vsftpd.conf file from backup
if [ -f $vsftpd_conf_file.bak ]; then
  mv $vsftpd_conf_file.bak $vsftpd_conf_file
fi

echo "Anonymous FTP has been restored to its original state."





cat $result

echo ; echo