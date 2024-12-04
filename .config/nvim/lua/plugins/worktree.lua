return {
  "polarmutex/git-worktree.nvim",
  version = "^2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>gwa",
      ":Telescope git_worktree create_git_worktree<CR>",
      desc = "create-worktree",
      silent = true,
    },
    {
      "<leader>gwl",
      ":Telescope git_worktree git_worktree<CR>",
      desc = "list-worktrees",
      silent = true,
    },
  },
  -- init = function()
  --   local wk = require("which-key")
  --   wk.register({
  --     ["gw"] = { name = "+worktree" },
  --   }, { mode = "n", prefix = "<leader>" })
  -- end,
  -- config = function()
  --   require("telescope").load_extension("git_worktree")
  -- end,
}
