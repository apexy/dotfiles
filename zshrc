# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit
# 
for function in ~/.zsh/functions/*; do
  source $function
done

# automatically enter directories without cd
setopt auto_cd

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# expand functions in the prompt
# setopt prompt_subst

# prompt
# export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=4096

# look for ey config in project dirs
# export EYRC=./.eyrc

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Try to correct command line spelling
setopt CORRECT CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


##############################################################################

ZSH=$HOME/.oh-my-zsh

# ZSH_THEME="random"
ZSH_THEME="robbyrussell"

alias viv="mvim ~/.vimrc"
alias viz="mvim ~/.zshrc"
# alias viohz="mvim ~/.oh-my-zsh"
alias rbe="rbenv"
alias cl="clear"
alias tmux="TERM=screen-256color-bce tmux"

alias devup="mysql.server start && sudo /Applications/MAMP/Library/bin/httpd -f /Library/Application\ Support/appsolute/MAMP\ PRO/conf/httpd.conf -k start"
alias devdown="mysql.server stop && sudo /Applications/MAMP/Library/bin/httpd -f /Library/Application\ Support/appsolute/MAMP\ PRO/conf/httpd.conf -k stop"

plugins=(brew osx history colored-man encode64 tmux tmuxinator 
         vundle git git-extras git-flow postgres 
         rbenv bundler ruby rails4 rake zeus)

source $ZSH/oh-my-zsh.sh
unsetopt correct

export PATH=/usr/local/bin:/usr/local/sbin:~/.nvm/v0.8.9/bin:$PATH

#path=(
    #/usr/local/bin
    #/Users/Yuan/.nvm/v0.8.9/bin
    #$path
#)

eval "$(rbenv init -)"
[[ -s "$HOME/.tmuxinator/scripts/tmuxinator" ]] && source "$HOME/.tmuxinator/scripts/tmuxinator"
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

