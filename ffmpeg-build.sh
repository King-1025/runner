#!/usr/bin/env bash

ROOT=$(pwd)
FFMPEG_DIR=$ROOT/ffmpeg
X264_DIR=$ROOT/x264
INSTALL_DIR=$ROOT/result/ffmpeg
YASM="yasm-1.3.0"


mkdir -p $FFMPEG_DIR
mkdir -p $INSTALL_DIR

wget http://www.tortall.net/projects/yasm/releases/$YASM.tar.gz \
&& \
tar -xzf $YASM.tar.gz \
&& \
cd $YASM \
&& \
./configure \
&& \
make -j 4 \
&& \
sudo make install \
&& \
cd $ROOT \
&& \
wget https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.gz \
&& \
tar -xzf nasm-2.14.02.tar.gz \
&& \
cd nasm-2.14.02 \
&& \
./configure \
&& \
make -j 4 \
&& \
sudo make install \
&& \
git clone https://github.com/mirror/x264.git $X264_DIR -j 4 \
&& \
cd $X264_DIR \
&& \
./configure \
&& \
make -j 4 \
&& \
sudo make install \
&& \
git clone https://git.ffmpeg.org/ffmpeg.git $FFMPEG_DIR -j 4 \
&& \
cd $FFMPEG_DIR \
&& \
./configure --prefix=$INSTALL_DIR --enable-gpl --enable-version3 --enable-static --enable-libx264 --extra-ldflags='-lx264 -lpthread -lm -ldl' --enable-static --disable-shared --enable-pthreads --enable-encoder=libx264 --disable-doc --disable-ffplay --disable-ffprobe \
&& \
make -j 4 \
&& \
make install

if [ ! -e $INSTALL_DIR ]; then
   echo build ffmpeg failed!
   exit 1
fi
