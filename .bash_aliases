#   ____    _    ____  _   _      _    _     ___    _    ____  _____ ____
#  | __ )  / \  / ___|| | | |    / \  | |   |_ _|  / \  / ___|| ____/ ___|
#  |  _ \ / _ \ \___ \| |_| |   / _ \ | |    | |  / _ \ \___ \|  _| \___ \
#  | |_) / ___ \ ___) |  _  |  / ___ \| |___ | | / ___ \ ___) | |___ ___) |
#  |____/_/   \_\____/|_| |_| /_/   \_\_____|___/_/   \_\____/|_____|____/
#

source /home/dmazuruk/dev/aliases_work

# Git
grbih() {
    grbi HEAD~"$1"
}
alias grbi1="grbih 1"
alias grbi2="grbih 2"
alias grbi3="grbih 3"
alias grbi4="grbih 4"
alias grbi5="grbih 5"
alias grbi6="grbih 6"
alias grbi7="grbih 7"
alias grbi8="grbih 8"
alias grbi9="grbih 9"
alias grbi10="grbih 10"

grsh() {
    git reset --soft HEAD~"$1"
}
alias grs1="grsh 1"
alias grs2="grsh 2"
alias grs3="grsh 3"
alias grs4="grsh 4"
alias grs5="grsh 5"
alias grs6="grsh 6"
alias grs7="grsh 7"
alias grs8="grsh 8"
alias grs9="grsh 9"
alias grs10="grsh 10"

gccs() {
    git log --oneline | ag "$1" | wc -l
}

alias grod="git rebase origin/develop"
alias gcod="git checkout develop"
alias gcodl="git checkout develop | git pull"
alias gcob="git checkout \$(git branch | fzf)"
alias gcorb="git checkout --track \$(git branch -r | fzf)"
alias gpuo="git push -u origin"
alias gpuoc="current_branch_name=\$(git branch --show-current) && git push -u origin $current_branch_name"

# Yanking
yanking() {
    yank-cli -"$1" "$2" -- xsel -b
}
yankingd() {
    yanking d "$1"
}
yankingg() {
    yanking g "$1"
}
alias yy="xsel -b"
alias yyy="yank-cli -- xsel -b"
alias yyl="yank-cli -l -- xsel -b"
alias yyd=yankingd
alias yyg=yankingg
yankFromHistory() {
    history | tac | awk '{$1=""; cmd=substr($0,$2); gsub("^ ","",cmd); print cmd}' | fzf | tr -d '\n' | sed 's/\\n/\n/g' | yy
}
alias yyh=yankFromHistory

# Edit config files
alias ea="vi /home/dmazuruk/.bash_aliases"
alias ev="vi /home/dmazuruk/.vimrc"
alias ez="vi /home/dmazuruk/.zshrc"
alias eb="vi /home/dmazuruk/.bashrc"
alias ei="vi /home/dmazuruk/.config/i3/config"

# Other
alias h="history"
alias firefox24="~/tools/firefox/firefox -no-remote -P firefox-24"
alias sup="sudo apt-get update"
alias sug="sudo apt-get upgrade"
alias sdu="sudo apt-get dist-upgrade"
alias sin="sudo apt-get install"
alias tpl="trans :pl"
alias ten="trans :en"

alias wttrlub="curl wttr.in/lublin"
wttr() {
   curl wttr.in/"$1"
}
mkcd() {
    mkdir "$1" && cd "$1" || exit
}

alias cat="bat"
alias ping='~/tools/prettyping --nolegend'
alias preview="fzf --preview 'bat --color \"always\" {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(vi {})+abort'"
alias du="ncdu --color dark -rr -x"
alias help="tldr"
alias clr="clear"

drawFrom() {
    drawList=("$@"); echo "${drawList[(RANDOM % $#drawList[@]) + 1]}"
}
alias xo="xdg-open"

# FZF functions
#
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
# fep [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fep() {
  local files
  IFS=$'\n' files=($(find $1 | fzf-tmux --query="$2" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
sfe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && sudo ${EDITOR:-vim} "${files[@]}"
}
# fep [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
sfep() {
  local files
  IFS=$'\n' files=($(find $1 | fzf-tmux --query="$2" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && sudo ${EDITOR:-vim} "${files[@]}"
}
vg() {
  local file

  file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1}')"

  if [[ -n $file ]]
  then
     vim $file
  fi
}
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}
# fds - cd into the directory of the selected file
fds() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
