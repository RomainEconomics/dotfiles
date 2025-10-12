return {
	'harrisoncramer/gitlab.nvim',
	dependencies = {
		'MunifTanjim/nui.nvim',
		'nvim-lua/plenary.nvim',
		'sindrets/diffview.nvim',
		'stevearc/dressing.nvim', -- Recommended but not required. Better UI for pickers.
		'nvim-tree/nvim-web-devicons', -- Recommended but not required. Icons in discussion tree.
	},
	build = function() require('gitlab.server').build(true) end, -- Builds the Go binary
	config = function() require('gitlab').setup() end,

	-- :h gitlab.nvim.api

	-- See Pipeline
	-- require("gitlab").pipeline()
	--

	-- Choose a MR
	-- require("gitlab").choose_merge_request()

	-- Create MR
	-- require("gitlab").create_mr({ target = "main" })
	-- require("gitlab").create_mr({ template_file = "my-template.md", title = "Fix bug XYZ", description = "Some desc"})

	-- Create a global note in a MR
	-- require("gitlab").create_note()
	--
	-- Approve/Revoke MR
	-- require("gitlab").approve()
	-- require("gitlab").revoke()
	--
	-- Merge MR
	-- require("gitlab").merge()
	-- require("gitlab").merge({ squash = false, delete_branch = false })
	--
	-- Others
	-- require("gitlab").review()
	-- require("gitlab").create_comment()
	-- require("gitlab").create_multiline_comment()
	-- require("gitlab").create_comment_suggestion()
	--
	-- require("gitlab").add_reviewer()
	-- require("gitlab").delete_reviewer()
	-- require("gitlab").add_assignee()
	-- require("gitlab").delete_assignee()
	--
	-- Restart gitlab.nvim server
	-- require("gitlab.server").restart()
}
