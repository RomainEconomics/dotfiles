
const project = "/home/rjouhameau/dotfiles/.config/scripts"

export def html-to-text [url: string] {
	let cmd = $"($project)/html_to_text.py"
	uv run $cmd --url $url
}

export def cut-pdf [path: string, pages: list] {
	let cmd = $"($project)/pdf_utils.py"
	uv run $cmd --action cut --path $path --pages ...$pages
}

export def analyze-pdf [path: string] {
	let cmd = $"($project)/pdf_utils.py"
	uv run $cmd --action analyze --path $path 
}
