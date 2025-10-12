return {
	'folke/flash.nvim',
	event = 'VeryLazy',
	vscode = true,
	opts = {
		modes = {
			search = {
				enabled = true,
			},
			char = { jump_labels = true },
		},
	},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- Step 1: choose an operator ("d", "y", "c"...)
      -- Step 2: type "r"
      -- Step 3: type what you're looking for
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- Step 1: choose an operator ("d", "y", "v"...)
      -- Step 2: type "R"
      -- Step 3: type what you're looking for
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
}
