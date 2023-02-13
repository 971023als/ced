#!/bin/bash

. function.sh

BAR

CODE [U-13] SUID, SGID, Sticky bit 설정 및 권한 설정		

cat << EOF >> $result

[양호]: 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있지 않은 
경우

[취약]: 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있는 경우

EOF

BAR


# Restore original permissions for specified files
restore_permissions() {
filename=$1
original_permission=$(stat -c "%a" "$filename")
sudo chmod "$original_permission" "$filename"
INFO "다음에 대한 원래 사용 권한 복원 $filename"
}

# Restore original permissions for all specified files
restore_permissions .profile
restore_permissions .kshrc
restore_permissions .cshrc
restore_permissions .bashrc
restore_permissions .bash_profile
restore_permissions .login
restore_permissions .exrc
restore_permissions .netrc



cat $result

echo ; echo
