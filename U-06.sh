#!/bin/bash

. function.sh

BAR

CODE [U-06] 파일 및 디렉터리 소유자 설정

cat << EOF >> $result

[양호]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하지 않는 경우

[취약]: 소유자가 존재하지 않는 파일 및 디렉터리가 존재하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  



# Check if TMP1 file exists
if [ -f "$TMP1" ]; then
  # Read TMP1 file line by line
  while IFS= read -r line; do
    # Split line into an array using space as a separator
    arr=($line)
    # The first element of the array is the file or directory path
    path=${arr[0]}
    # The second element of the array is the original owner
    owner=${arr[1]}
    # Restore the original owner of the file or directory
    sudo chown $owner $path
  done < "$TMP1"
  # Remove TMP1 file
  rm $TMP1
else
  # TMP1 file does not exist, display an error message
  echo "Error: TMP1 file not found, unable to restore the original state"
fi



cat $result

echo ; echo