return {
	'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
	'famiu/bufdelete.nvim',
	{ 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
	'mg979/vim-visual-multi', -- multiple cursors in vim
	{ 'Juksuu/worktrees.nvim', config = function() require('worktrees').setup() end },
}
