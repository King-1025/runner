#!/usr/bin/env bash

REPORT=$(pwd)/report.txt

function check()
{
  echo $1 | tee -a $REPORT
  echo "=======================================================" | tee -a $REPORT
  $1 | tee -a $REPORT
  echo "=======================================================" | tee -a $REPORT
  echo "" | tee -a $REPORT
}

rm -rf $REPORT

check "date"
check "ifconfig"
check "df -h"
check "whoami"
#check "ping -c 3 google.com"
