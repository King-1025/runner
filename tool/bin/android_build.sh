#!/usr/bin/env bash

if [ ! -e "$1" ]; then
  echo not exist! $1
  exit 1
fi

ROOT="$1"

cd $ROOT

echo "ROOT: $ROOT"
ls -lha $ROOT

RELEASE=./app/build/outputs/apk
OUTPUT=./output
KS=$ANDROID_KS
KSP=$ANDROID_KSP

pip install requests
sudo apt install apksigner -y

./gradlew :app:build

rm -rf $OUTPUT && mkdir $OUTPUT

for i in $(find $RELEASE -name *.apk -print); do
   in=$i
   out="$OUTPUT/$(echo $(basename $i) | sed "s/un//g")"
   apksigner sign -v --ks $KS --in $in --out $out --ks-pass file:$KSP
done

if [ ! -z $ESC_KEY ]; then
   esc "$(echo $ESC_KEY | awk -F "/" '{print $1" "$2}')" "$OUTPUT"
else
   echo "not found! ESC_KEY"
   exit 1
fi
