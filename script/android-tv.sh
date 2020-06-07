#!/usr/bin/env bash

git clone https://github.com/android/tv-samples.git -j 4

root=$(pwd)

subdir=$root/tv-samples/Leanback

path=$(find $subdir -name "Android*" -print)

sed -i "s/LAUNCHER/#/g"          $path 
sed -i "s/LEANBACK_#/LAUNCHER/g" $path 
sed -i "s/#/LEANBACK_LAUNCHER/g" $path

android_build $subdir

subdir=$root/tv-samples/LeanbackShowcase

path=$(find $subdir -name "Android*" -print)

sed -i "s/LEANBACK_//g" $path

android_build $subdir
