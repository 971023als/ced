#!/bin/bash

. function.sh

BAR

CODE [U-45] root 계정 su 제한		

cat << EOF >> $result

[양호]: su 명령어를 특정 그룹에 속한 사용자만 사용하도록 제한되어 있는 경우
※ 일반사용자 계정 없이 root 계정만 사용하는 경우 su 명령어 사용제한 불필요

[취약]: su 명령어를 모든 사용자가 사용하도록 설정되어 있는 경우

EOF

BAR

# Remove the SUID bit from the su command
sudo chmod u-s $(which su)

# Remove group restriction for su command
sudo chgrp root $(which su)
sudo chmod g+rwx $(which su)
sudo chmod g-rxs $(which su)

echo "The original state of the su command has been restored."



cat $result

echo ; echo

