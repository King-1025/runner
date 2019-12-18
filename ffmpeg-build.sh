#!/usr/bin/env bash

ROOT=$(pwd)
FFMPEG_DIR=$ROOT/ffmpeg
INSTALL_DIR=$ROOT/result/ffmpeg
YASM="yasm-1.3.0"


mkdir -p $FFMPEG_DIR
mkdir -p $INSTALL_DIR

wget http://www.tortall.net/projects/yasm/releases/$YASM.tar.gz && tar -xzvf $YASM.tar.gz && cd $YASM && ./configure && make -j 4 && sudo make install \
&& \
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
