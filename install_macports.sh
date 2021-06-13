#!/bin/bash

curl -O https://distfiles.macports.org/MacPorts/MacPorts-2.7.1.tar.bz2
tar xf MacPorts-2.7.1.tar.bz2

cd MacPorts-2.7.1/
./configure
make
sudo make install

## export macports
cat << 'EOF' >> ~/.profile
# export macports
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export MANPATH="/opt/local/man:$MANPATH"
EOF

source ~/.profile

sudo port selfupdate
