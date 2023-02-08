#!/bin/bash

 

. function.sh

 

BAR

CODE [U-59] 숨겨진 파일 및 디렉터리 검색 및 제거

cat << EOF >> $result

[양호]: 디렉터리 내 숨겨진 파일을 확인하여, 불필요한 파일 삭제를 완료한 경우

[취약]: 디렉터리 내 숨겨진 파일을 확인하지 않고, 불필요한 파일을 방치한 경우

EOF

BAR


TMP1=`SCRIPTNAME`.log

> $TMP1 



# Define the location of backup files
backup_files_dir="$HOME/hidden_files_backup"

# Check if the backup directory exists
if [ ! -d "$backup_files_dir" ]; then
  echo "Backup directory does not exist, no files to restore"
  exit 1
fi

# Restore hidden files and directories
for file in $(ls "$backup_files_dir"); do
  cp "$backup_files_dir/$file" "$file"
done

# Remove the backup directory
rm -rf "$backup_files_dir"

echo "Original state has been restored successfully."




cat $result

echo ; echo 

 
