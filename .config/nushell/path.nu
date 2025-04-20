

$env.path ++= [
	($env.HOME | path join "bin"),
	($env.HOME | path join ".local/bin"),
	($env.HOME | path join ".local/share/bob/nvim-bin"),
	($env.HOME | path join ".bun/bin"),
	($env.HOME | path join ".cargo/bin"),
	($env.HOME | path join ".luarocks/bin"),
	($env.HOME | path join ".npm-global/bin"),
	"/home/linuxbrew/.linuxbrew/bin",
]

$env.path = ($env.path | uniq)

# $env.KUBECONFIG = '~/.kube/config'
$env.KUBECONFIG = ^find ~/.kube/ -iname "kubeconfig*" | tr "\n" ":"


