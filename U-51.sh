#!/bin/bash

 

. function.sh

 


TMP2=/tmp/tmp1

TMP3=/tmp/tmp2

TMP4=/tmp/tmp3

 

BAR

CODE [U-51] 계정이 존재하지 않는 GID 금지

cat << EOF >> $result

양호: 존재하지 않는 계정에 GID 설정을 금지한 경우

취약: 존재하지 않은 계정에 GID 설정이 되어있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

> $TMP1

necessary_groups=("root" "sudo" "sys" "adm" "wheel"
"daemon" "bin" "lp" "dbus" "rpc" "rpcuser" "haldaemon"
"apache" "postfix" "gdm" "adiosl" "mysql" "cubrid"
"messagebus" "syslog" "avahi" "whoopsie"
"colord" "systemd-network" "systemd-resolve"
"systemd-timesync" "mysql" "user"
"www-data" "sync")

# Read the necessary groups from the log file
original_groups=$(cat "$TMP1")

# Add back the groups that were deleted
for group in $original_groups; do
  if ! echo "${necessary_groups[@]}" | grep -wq "$group"; then
    groupadd "$group"
  fi
done




 

cat $result

echo ; echo
