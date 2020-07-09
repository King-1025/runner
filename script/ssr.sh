#!/usr/bin/env bash

ROOT=$(pwd)
RESULT=$ROOT/result

mkdir $RESULT && cd $RESULT

git clone https://github.com/ShadowsocksR-Live/shadowsocksr-native.git -j4
git submodule update --init
git submodule foreach -q 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'
