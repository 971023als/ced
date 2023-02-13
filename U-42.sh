#!/bin/bash

. function.sh 

BAR

CODE [U-42] 최신 보안패치 및 벤더 권고사항 적용

cat << EOF >> $result
[양호]: 패치 적용 정책을 수립하여 주기적으로 패치를 관리하고 있는 경우
[취약]: 패치 적용 정책을 수립하지 않고 주기적으로 패치관리를 하지 않는 경우
EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# Set log file path
log_file="/var/log/patch.log"

# Verify that the /var/log/patch.log file exists
if [ -e $log_file ]; then
  # Check if the log file contains information about installed patches
  if grep -q "Patches installed" $log_file; then
    # Get the list of installed patches
    installed_patches=`grep "Patches installed" $log_file | awk '{print $3}'`
    
    # Uninstall the patches
    sudo yum remove $installed_patches

    # Check if the patches were successfully removed
    if [ $? -eq 0 ]; then
      OK "Patches were successfully uninstalled."
    else
      WARN "Unable to uninstall the patches."
    fi
  else
    OK "No patches were installed."
  fi
else
  WARN "$log_file does not exist."
fi

cat $result

echo ; echo