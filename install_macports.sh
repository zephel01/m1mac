#!/bin/bash

mkdir -p /opt/mports

cd /opt/mports
git clone https://github.com/macports/macports-base.git

cd macports-base
git checkout v2.7.1  # skip this if you want to use the development version

cd /opt/mports/macports-base
./configure --enable-readline
make
sudo make install
make distclean

echo "export PATH=/opt/local/bin:/opt/local/sbin:$PATH" >> ~/.profile
