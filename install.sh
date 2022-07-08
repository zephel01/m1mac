#!/bin/bash
### M1 Mac build 

# zsh permission
chmod 755 /usr/local/share/zsh/site-functions
chmod 755 /usr/local/share/zsh

echo "$SHELL"

## brew install arm64
arch -arm64e /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

## brew install x86_64
arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

cat ~/m1mac/.zshrc >> ~/.zshrc

exec $SHELL -l

=brew install git

## install asdf
brew install asdf

## software install
brew install coreutils automake autoconf openssl libyaml readline libxslt libtool unixodbc unzip curl

exec $SHELL -l

# asdf plugin add python
asdf plugin-add python
asdf install python 3.9.5
asdf global python 3.9.5


