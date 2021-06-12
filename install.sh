#!/bin/bash
### M1 Mac build 

# change bash
chsh -s /bin/bash

echo "$SHELL"

## brew install
arch -arm64e /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

## shellenv
cat << 'EOF' >> ~/.bash_profile
# shellenv
eval "$(/opt/homebrew/bin/brew shellenv)"
EOF

exec $SHELL -l

## check brew version
brew --version

brew install git

git clone https://github.com/anyenv/anyenv ~/.anyenv

## export anyenv
cat << 'EOF' >> ~/.bash_profile
# export anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init - --no-rehash)"
EOF

~/.anyenv/bin/anyenv init
exec $SHELL -l
anyenv install --init

## install pyenv
anyenv install pyenv

## export pyenv
cat << 'EOF' >> ~/.bash_profile
# export pyenv
export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
EOF

exec $SHELL -l

pyenv install 3.6.10
pyenv global 3.6.10

pyenv rehash

## pip update

pip install --upgrade pip

