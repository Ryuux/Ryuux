export ZSH="$HOME/.oh-my-zsh"
export GITHUB_USER="Ryuux"

HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history

ZSH_THEME="awesomepanda"

plugins=(zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# Functions
function express(){
	mkdir {app,controllers,db,libs,middlewares,routes}
}

function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xarg
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sor
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

alias-finder() {
  local cmd="" exact="" longer="" wordStart="" wordEnd="" multiWordEnd=""
  for i in $@; do
    case $i in
      -e|--exact) exact=true;;
      -l|--longer) longer=true;;
      *)
        if [[ -z $cmd ]]; then
          cmd=$i
        else
          cmd="$cmd $i"
        fi
        ;;
    esac
  done
  cmd=$(sed 's/[].\|$(){}?+*^[]/\\&/g' <<< $cmd) # adds escaping for grep
  if (( $(wc -l <<< $cmd) == 1 )); then
    while [[ $cmd != "" ]]; do
      if [[ $longer = true ]]; then
        wordStart="'{0,1}"
      else
        wordEnd="$"
        multiWordEnd="'$"
      fi
      if [[ $cmd == *" "* ]]; then
        local finder="'$cmd$multiWordEnd"
      else
        local finder=$wordStart$cmd$wordEnd
      fi
      alias | grep -E "=$finder"
      if [[ $exact = true || $longer = true ]]; then
        break
      else
        cmd=$(sed -E 's/ {0,1}[^ ]*$//' <<< $cmd) # removes last word
      fi
    done
  fi
}

preexec_alias-finder() {
  if [[ $ZSH_ALIAS_FINDER_AUTOMATIC = true ]]; then
    alias-finder $1
  fi
}

encode64() {
    if [[ $# -eq 0 ]]; then
        cat | base64
    else
        printf '%s' $1 | base64
    fi
}

encodefile64() {
    if [[ $# -eq 0 ]]; then
        echo "You must provide a filename"
    else
        base64 -i $1 -o $1.txt
        echo "${1}'s content encoded in base64 and saved as ${1}.txt"
    fi
}

decode64() {
    if [[ $# -eq 0 ]]; then
        cat | base64 --decode
    else
        printf '%s' $1 | base64 --decode
    fi
}

# Aliases
alias zsh="source ~/.zshrc"
alias zshconfig="mate ~/.zshrc"

alias g='git'
alias gst='git status'
alias gl='git pull'
alias gup='git fetch && git rebase'
alias gp='git push'
gdv() { git diff -w "$@" | view - }
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gco='git checkout'
alias gcm='git checkout master'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias glg='git log --stat --max-count=5'
alias glgg='git log --graph --max-count=5'
alias gss='git status -s'
alias ga='git add'
alias gm='git merge'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'

function branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function repo() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

alias db='deno bundle'
alias dc='deno compile'
alias dca='deno cache'
alias dfmt='deno fmt'
alias dh='deno help'
alias dli='deno lint'
alias drn='deno run'
alias drA='deno run -A'
alias drw='deno run --watch'
alias dts='deno test'
alias dup='deno upgrade'

alias dbl='docker build'
alias dcin='docker container inspect'
alias dcls='docker container ls'
alias dclsa='docker container ls -a'
alias dib='docker image build'
alias dii='docker image inspect'
alias dils='docker image ls'
alias dipu='docker image push'
alias dirm='docker image rm'
alias dit='docker image tag'
alias dlo='docker container logs'
alias dnc='docker network create'
alias dncn='docker network connect'
alias dndcn='docker network disconnect'
alias dni='docker network inspect'
alias dnls='docker network ls'
alias dnrm='docker network rm'
alias dpo='docker container port'
alias dpu='docker pull'
alias dr='docker container run'
alias drit='docker container run -it'
alias drm='docker container rm'
alias 'drm!'='docker container rm -f'
alias dst='docker container start'
alias drs='docker container restart'
alias dsta='docker stop $(docker ps -q)'
alias dstp='docker container stop'
alias dtop='docker top'
alias dvi='docker volume inspect'
alias dvls='docker volume ls'
alias dvprune='docker volume prune'
alias dxc='docker container exec'
alias dxcit='docker container exec -it'

alias pipi="pip install"
alias pipu="pip install --upgrade"
alias pipun="pip uninstall"
alias pipgi="pip freeze | grep"
alias piplo="pip list -o"
alias pipreq="pip freeze > requirements.txt"
alias pipir="pip install -r requirements.txt"

alias y="yarn"
alias ya="yarn add"
alias yad="yarn add --dev"
alias yap="yarn add --peer"
alias yb="yarn build"
alias ycc="yarn cache clean"
alias yd="yarn dev"
alias yf="yarn format"
alias yga="yarn global add"
alias ygls="yarn global list"
alias ygrm="yarn global remove"
alias ygu="yarn global upgrade"
alias yh="yarn help"
alias yi="yarn init"
alias yin="yarn install"
alias yln="yarn lint"
alias ylnf="yarn lint --fix"
alias yls="yarn list"
alias yout="yarn outdated"
alias yp="yarn pack"
alias yrm="yarn remove"
alias yrun="yarn run"
alias ys="yarn serve"
alias yst="yarn start"
alias yt="yarn test"
alias ytc="yarn test --coverage"
alias yuc="yarn global upgrade && yarn cache clean"
alias yui="yarn upgrade-interactive"
alias yuil="yarn upgrade-interactive --latest"
alias yup="yarn upgrade"
alias yv="yarn version"
alias yw="yarn workspace"
alias yws="yarn workspaces"

alias ninit="npm init"
alias ni="npm install --save -E"
alias nr="npm run"
alias nid="npm install -D -E"
alias nu="npm update"

alias vsc="code ."
alias vsca="code --add"
alias vscd="code --diff"
alias vscg="code --goto"
alias vscn="code --new-window"
alias vscr="code --reuse-window"
alias vscw="code --wait"
alias vscu="code --user-data-dir"

alias vsced="code --extensions-dir"
alias vscie="code --install-extension"
alias vscue="code --uninstall-extension"

alias vscv="code --verbose"
alias vscl="code --log"
alias vscde="code --disable-extensions"

alias e64=encode64
alias ef64=encodefile64
alias d64=decode64
# Pnpm
alias pi="pnpm install"
alias pa="pnpm add"
alias pu="pnpm update"
alias pr="pnpm uninstall"
alias prun="pnpm run"

alias cat="bat"
alias meminfo="free -m -l -t"
alias psmem="ps auxf | sort -nr -k 4"
alias pscpu="ps auxf | sort -nr -k 3"
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/down
alias ping="ping -c 5"
alias weather="curl wttr.in/Chile"

# Sudo
alias openports="sudo netstat"
alias find="sudo find / -name"
alias install="sudo apt-get install"
alias li="sudo dpkg -i"
alias update="sudo apt-get update && sudo apt-get upgrade"

alias l="exa --icons"
alias ll="exa -l --icons"
