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

## install anyenv
git clone https://github.com/anyenv/anyenv ~/.anyenv

## export anyenv
cat << 'EOF' >> ~/.zshrc
# export anyenv
if [ -e "$HOME/.anyenv" ]
then
    export ANYENV_ROOT="$HOME/.anyenv"
    export PATH="$ANYENV_ROOT/bin:$PATH"
    if command -v anyenv 1>/dev/null 2>&1
    then
        eval "$(anyenv init - zsh)"
    fi
fi
EOF

exec $SHELL -l
anyenv install --init

## install anyenv plugins
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

anyenv update

## install pyenv
anyenv install pyenv

## export pyenv
cat << 'EOF' >> ~/.zprofile
# export pyenv
export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
EOF

cat << 'EOF' >> ~/.zshrc
# export pyenv
eval "$(pyenv init -)"
EOF

exec $SHELL -l

arch -arch x86_64 env PATH=${PATH/\/opt\/homebrew\/bin:/} pyenv install 3.8.7
pyenv global 3.8.7

pyenv rehash

## pip update

pip install --upgrade pip


