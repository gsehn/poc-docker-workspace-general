# ls
alias ll="ls -lahHF --color=auto"
alias la="ls -A --color=auto"
alias ls="ls -a --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# general
alias c="clear"
alias vimrc="vim ~/.vimrc"

# git
alias gs="gss -s"
alias gss="git status"
alias gpr="git pull --rebase --prune origin"
alias gr="git rebase -i"
alias grim="git rebase -i master"
alias gro="git reset --hard origin/master"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcom="git checkout master"
alias gcod="git checkout develop"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset' --abbrev-commit --date=relative"
alias gb="git branch"
alias gbp="git remote update origin --prune"
alias gbd="git push origin --delete"

# Folders
alias ws="cd ~/workspaces"
alias opt="cd /opt && ll"

# docker
alias d="docker"
alias dl="docker logs -f"
alias de="docker exec -it"
alias dcp="docker-compose"
alias dprune="yes | docker container prune && yes | docker volume prune"

# kubernetes
alias k="kubectl"
alias kl="kubectl logs -f"

# terraform
alias t="terraform"

# python
alias p3="python3"
alias server="p3 -m http.server --bind 192.168.100.126 8000"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# tools
alias rm-node_modules='sudo find . -name "node_modules" -type d -exec rm -rf "{}" \;'
alias find-node_modules='sudo find . -name "node_modules" -type d'
alias rm-icon='sudo find . -name "Icon?" -exec rm -f "{}" \;'
alias find-icon='sudo find . -name "Icon?"'

# klarna
alias disc="cd ~/workspaces/discordia"
alias eris="cd ~/workspaces/eris"
alias cred="cd ~/workspaces/credentials"
alias oncall="cd ~/workspaces/tools/scripts/oncall"

# global npm
alias gnpm="~/n/bin/npm"
