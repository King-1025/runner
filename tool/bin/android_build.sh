#!/usr/bin/env bash

if [ ! -e "$1" ]; then
  echo not exist! $1
  exit 1
fi

ROOT="$1"

cd $ROOT

echo "ROOT: $ROOT"
ls -lha $ROOT

APP_PREFIX=$(basename $ROOT)
RELEASE=./app/build/outputs/apk
OUTPUT=./output
KS=$ANDROID_KS
KSP=$ANDROID_KSP

pip install requests
sudo apt install apksigner -y

bash ./gradlew build

rm -rf $OUTPUT && mkdir $OUTPUT

if [ "${APP_PREFIX}" != "" ] && [ "${APP_PREFIX}" != "." ]; then
   APP_PREFIX="${APP_PREFIX}-"
else
   APP_PREFIX=""
fi

for i in $(find $RELEASE -name *.apk -print); do
   in=$i
   out="$OUTPUT/${APP_PREFIX}$(echo $(basename $i) | sed "s/un//g")"
   echo sign $in...
   apksigner sign -v --ks $KS --in $in --out $out --ks-pass file:$KSP
   if [ $? -eq 0 ]; then
      echo "save as $out"
      cp $out $RESULT
   fi
   echo ""
done

if [ ! -z $ESC_KEY ]; then
   comm="esc $(echo $ESC_KEY | awk -F "/" '{print $1" "$2}') $OUTPUT"
   $comm
else
   echo "not found! ESC_KEY"
   exit 1
fi
