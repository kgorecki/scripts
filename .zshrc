function add_directory_to_path()
{
  if [[ -d "$1" ]] && [[ :$PATH: != *:"$1":* ]]; then
    export PATH=$1:$PATH
  fi
}

# PATH:
add_directory_to_path ${HOME}/bin
add_directory_to_path ${HOME}/prog

# aliases:
alias ls='ls -G'
alias grep='grep -n'

# colours:
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd" # ls colors like in Linux

# git completion:
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit
zstyle ":completion:*:commands" rehash 1 # refresh apps in PATH

# prompt:
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd() { vcs_info }
setopt prompt_subst
function battery
{
  if [[ `uname` == "Darwin" ]]; then
    pmset -g batt | command grep -Eo "\d+%" | cut -d% -f1
  else
    acpi -b | grep -P -o '[0-9]+(?=%)'
  fi
}
function getConfirmed
{
#  curl -s https://covid2019-api.herokuapp.com/country/${1} | jq -r '.. |.confirmed? // empty'
}
RPROMPT="\$vcs_info_msg_0_ | "'$(getConfirmed fi)'" | "'$(getConfirmed pl)'" | "'$(battery)'"%%"
# taken from here: https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '
zstyle ':vcs_info:git:*' formats '%{%F{yellow}%}%r%{%f%}: %{%F{green}%}%b%{%f%}'

if which thefuck >> /dev/null; then
  eval $(thefuck --alias)
fi

