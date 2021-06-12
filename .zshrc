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

setopt magic_equal_subst

PROMPT="%B%F{green}%n@[%*]%f%b:%B%F{blue}%~%f%b%# "

alias ls='ls -AFG'
alias ll='ls -hlt'

alias history='history -Di'

# http://zsh.sourceforge.net/Doc/Release/Options.html#Description-of-Options
setopt hist_ignore_dups
setopt share_history
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=100000

setopt nonomatch
setopt correct

autoload -Uz compinit && compinit

# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#History-Control
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
# PROMPT=\$vcs_info_msg_0_'%# '
# zstyle ':vcs_info:git:*' formats '%b'

# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#vcs_005finfo-Configuration
zstyle ':vcs_info:git:*' formats '[%F{yellow}%b%f]%u%c'
zstyle ':vcs_info:git:*' actionformats '[%b|%a]'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr ":%F{green}!%f"
zstyle ':vcs_info:git:*' unstagedstr ":%F{red}+%f"
