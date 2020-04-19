#!/usr/bin/env bash

ROOT=$(pwd)
RESULT=$ROOT/result
REPORT=$RESULT/report.txt

function check()
{
  echo $1 | tee -a $REPORT
  echo "=======================================================" | tee -a $REPORT
  $1 | tee -a $REPORT
  echo "=======================================================" | tee -a $REPORT
  echo "" | tee -a $REPORT
}

rm -rf $RESULT && mkdir -p $RESULT

#check "date"
#check "ifconfig"
#check "df -h"
#check "whoami"
#check "$ROOT/ffmpeg-build.sh"
#check "ping -c 3 google.com"
#check "$ROOT/xy998.sh"
#check "$ROOT/gf.sh json"
#check "echo && echo && echo"
check "$ROOT/twil/run.sh"
