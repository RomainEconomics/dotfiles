
alias idl = cd ~/Documents/idl/

alias c = clear

def cheat_sheet [] {
    cd ~/Documents/repos/cheat-sheet/cheat_sheet/
    let file = fd . -t "file" | fzf --ansi --preview 'bat --color=always {1}'
    glow --style dark $file
}

def tldrf [] {
    let x = tldr --list | fzf --preview 'tldr {1} --color=always' --preview-window=right,70%
    tldr $x
}

alias ch = cheat_sheet
alias ca = chezmoi apply
alias cc = chat-gpt chat
alias ccm = chat-gpt chat --markdown
alias e = exit
alias req = touch requirements.txt
alias si = sudo apt-get install
alias ya = yazi


def sesh_connect [] {
    let dirs = sesh list
    let dir = $dirs | fzf-tmux -p 55%,60%
            [--no-sort
                --border-label " sesh "
                --prompt '⚡  '
                --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find'
                --bind 'tab:down,btab:up'
                --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)'
                --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t)'
                --bind 'ctrl-g:change-prompt(⚙<fe0f>  )+reload(sesh list -c)'
                --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)'
                --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)'
                --bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
    ]
    sesh connect $dir
}
alias s = sesh_connect

alias l = ls -l
alias ll = eza -lh --group-directories-first --icons -a
alias lt = eza --tree --level=2 --long --icons --git -a
alias tree = eza --tree --level=2 --long --icons --git


alias dud = du -d 1 -h # dis usage

# alias {gz,tgz,zip,lzh,bz1,tbz,Z,tar,arj,xz}=extract


############################################################################
# Docker
############################################################################

def drm [s: string] {
        docker stop $s; docker rm $s;
}


alias dps = docker ps
alias dc = docker compose
alias dcu = docker compose up
alias dcd = docker compose down
alias dcl = docker compose logs
alias dex = docker exec -it

alias lzd = lazydocker


############################################################################
# Kubernetes
############################################################################

alias k = kubectl
alias kx = kubectx
alias kn = kubens
alias kex = k exec -it
alias kgp = k get pods
alias kl = stern . -n
alias k8s = nvim +lua require(\kubectl\).open()

alias h = helm
alias hi = helm install
alias hu = helm uninstall
alias hup = helm upgrade
alias hls = helm ls
alias hlsd = helm ls --all --date
alias hse = helm search


############################################################################
# Git
############################################################################

# Check if main exists and use instead of master
# def git_main_branch[] {
#   command git rev-parse --git-dir &>/dev/null || return
#   local ref
#   for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,master}; do
#     if command git show-ref -q --verify $ref; then
#       echo ${ref:t}
#       return 0
#     fi
#   done
#
#   # If no main branch was found, fall back to master but return error
#   echo master
#   return 1
# }


alias g = git
alias ga = git add
alias gam = git add --all
alias gb = git_checkout_fzf
alias gbd = git branch --delete
alias gbdm = git branch --merged | xargs git branch -d
alias gg = git --no-pager log --oneline --decorate --all --graph -35
alias gc = git commit -m
alias gca = git commit --verbose --amend
alias gco = git checkout
alias gcb = git checkout -b
# alias gcm = git checkout $(git_main_branch)
alias gl = git pull
alias glr = git pull --rebase
alias glg = git log --graph --pretty = %Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset --date = short
alias gm = git merge
alias gma = git merge --abort
alias gr = git rebase
alias gra = git rebase --abort
alias grc = git rebase --continue
alias gri = git rebase --interactive
alias gp = git push
# alias gpsup = git push --set-upstream origin $(git_current_branch)
alias grh = git revert HEAD
alias grs = git restore --staged
alias gu = git reset --soft HEAD~1

alias lg = lazygit


############################################################################
# Python
############################################################################

def pystart [] {
    uv venv -p 3.12
    uv pip install -r requirements.txt
}

############################################################################
# Vim / Neovim
############################################################################

# alias vim = NVIM_APPNAME = nvim-lazy nvim
alias vim = nvim
alias v = nvim
alias vi = env NVIM_APPNAME=nvim-lazy nvim

############################################################################
# Tmux
############################################################################

alias tmls = tmux ls
alias tma = tmux a -t
alias tmd = tmux detach
alias tmk = tmux kill-session -t

