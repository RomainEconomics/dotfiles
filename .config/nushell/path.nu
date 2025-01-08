
use std "path add"

$env.PATH = ($env.PATH | split row (char esep))
path add ($env.HOME | path join "bin")
path add ($env.HOME | path join ".local" "bin")
path add ('/usr/' | path join "local" "bin")
path add ('/usr/' | path join "local" "go" "bin")
path add ($env.HOME | path join "go" "bin")
path add ($env.HOME | path join ".bun" "bin")
path add ($env.HOME | path join ".cargo" "bin")
path add ($env.HOME | path join ".npm-global" "bin")
path add ($env.HOME | path join ".luarocks" "bin")
path add ($env.HOME | path join ".local" "share" "bob" "nvim-bin")
path add "~/.local/share/bob/nvim-bin"
path add "/home/linuxbrew/.linuxbrew/bin"
$env.PATH = ($env.PATH | uniq)


# $env.KUBECONFIG = '~/.kube/config'
$env.KUBECONFIG = ^find ~/.kube/ -iname "kubeconfig*" | tr "\n" ":"


