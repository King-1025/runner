#!/usr/bin/env bash

ROOT=$(pwd)
RESULT=$ROOT/result

git clone https://github.com/qiniu/qplayer-sdk -j4

mv $ROOT/qplayer-sdk/android/samplePlayer $RESULT
