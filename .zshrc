typeset -U path PATH
path=(
	/opt/homebrew/bin(N-/)
	/usr/local/bin(N-/)
	$path
)

if (( $+commands[sw_vers] )) && (( $+commands[arch] )); then
	[[ -x /usr/local/bin/brew ]] && alias brew="arch -arch x86_64 /usr/local/bin/brew"
	alias x64='exec arch -x86_64 /bin/zsh'
	alias a64='exec arch -arm64e /bin/zsh'
	switch-arch() {
		if  [[ "$(uname -m)" == arm64 ]]; then
			arch=x86_64
		elif [[ "$(uname -m)" == x86_64 ]]; then
			arch=arm64e
		fi
		exec arch -arch $arch /bin/zsh
	}
fi

export LSCOLORS=cxfxcxdxbxegedabagacad

PROMPT="%B%F{green}%n@[%*]%f%b:%B%F{blue}%~%f%b%# "

alias ls='ls -AFG'
alias ll='ls -hlt'

alias history='history -Di'

zstyle ':completion:*' list-colors 'di=32'

setopt magic_equal_subst

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt nonomatch
setopt correct
setopt EXTENDED_HISTORY

# 補完機能を有効にする
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt list_packed
autoload colors
zstyle ':completion:*' list-colors ''
setopt correct
setopt no_beep
DIRSTACKSIZE=100
setopt AUTO_PUSHD

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# プロンプトカスタマイズ
PROMPT='
[%B%F{red}%n@%m%f%b:%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
%F{yellow}$%f '

# export gopath
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/bison/lib"

eval "$(/opt/homebrew/bin/brew shellenv)"

# asdf
. /usr/local/opt/asdf/libexec/asdf.sh

# export openssl
export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@3/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@3/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@3/lib/pkgconfig"

# export libxslt
export PATH="/usr/local/opt/libxslt/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/libxslt/lib"
export CPPFLAGS="-I/usr/local/opt/libxslt/include"
export PKG_CONFIG_PATH="/usr/local/opt/libxslt/lib/pkgconfig"

# export unzip
export PATH="/usr/local/opt/unzip/bin:$PATH"
