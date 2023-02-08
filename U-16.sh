#!/bin/bash

 

. function.sh

 

BAR

CODE [U-16] /dev에 존재하지 않는 device 파일 점검

cat << EOF >> $result  

[양호]: dev에 대한 파일 점검 후 존재하지 않은 device 파일을 제거한 경우

[취약]: dev에 대한 파일 미점검, 또는, 존재하지 않은 device 파일을 방치한 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  


# Check if TMP1 file exists
if [ -f "$TMP1" ]; then
  # Restore files in /dev directory
  while read file; do
    sudo touch "$file"
  done < "$TMP1"
fi


 

 
cat $result

echo ; echo

