export ZSH=/home/posten/.oh-my-zsh
ZSH_THEME="robbyrussell"
alias listwifi="sudo nmcli -p dev wifi list"
alias rescanwifi="sudo nmcli dev wifi rescan"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
plugins=(git python redis-cli web-search)


bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "\e[3~" delete-char

source $ZSH/oh-my-zsh.sh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory nomatch
bindkey -v
# # End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/posten/.zshrc'
zstyle ':completion:*' menu select
autoload -Uz compinit 
setopt completealiases
ncmpcppShow() { BUFFER="ncmpcpp"; zle accept-line; }
zle -N ncmpcppShow
[[ $- != *i* ]] && return

#eval "$(thefuck --alias fuck)"
alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
function connectnew(){
    sudo nmcli -p --ask dev wifi connect "$@"
}
function connect(){
    sudo nmcli con up "$@";
}
function cutIp(){
    sudo sysctl  -w  net.ipv4.ip_forward=0 
    sudo arpspoof  -i  wlp3s0 -t  192.168.0.1  "$@";
    sudo tcpkill  -i  wlp3s0 -3  net  "$@"
}
function uncutAll(){
    sudo sysctl -w net.ipv4.ip_forward=1
    sudo killall  arpspoof 
    sudo killall  tcpkill
}
export EDITOR="vim"
archey() {
    python ~/archey
}

#export NVM_DIR="/home/posten/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm  
archey

zstyle ':completion:*' menu select
cdUndoKey() {
  popd      > /dev/null
  zle       reset-prompt
  echo
  ls
  echo
}

cdParentKey() {
  pushd .. > /dev/null
  zle      reset-prompt
  echo
  ls
  echo
}

zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3A'      cdParentKey
bindkey '^[[1;3D'      cdUndoKey
