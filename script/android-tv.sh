#!/usr/bin/env bash

git clone https://github.com/android/tv-samples.git -j 4

subdir=./tv-samples/Leanback

path=$(find $subdir -name "Android*" -print)

sed "s/LAUNCHER/#/g" $path | sed "s/LEANBACK_#/LAUNCHER/g" | sed "s/#/LEANBACK_LAUNCHER/g" > $path

#android_build ./tv-samples/LeanbackShowcase

android_build $subdir
