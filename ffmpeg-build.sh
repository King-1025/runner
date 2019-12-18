#!/usr/bin/env bash

ROOT=$(pwd)
FFMPEG_DIR=$ROOT/ffmpeg
INSTALL_DIR=$ROOT/result/ffmpeg

mkdir -p $FFMPEG_DIR
mkdir -p $INSTALL_DIR

git clone https://git.ffmpeg.org/ffmpeg.git $FFMPEG_DIR -j 4 \
&& \
cd $FFMPEG_DIR \
&& \
./configure --prefix=$INSTALL_DIR \
&& \
make -j 4 \
&& \
make install

if [ ! -e $INSTALL_DIR ]; then
   echo build ffmpeg failed!
   exit 1
fi
