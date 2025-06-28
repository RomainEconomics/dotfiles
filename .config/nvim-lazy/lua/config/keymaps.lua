local keymap = vim.keymap.set
keymap({ "n", "v" }, "J", "5jzz", { desc = "Move down 5 rows and center" })

keymap({ "n", "v" }, "K", "5kzz", { desc = "Move up 5 rows and center" })
keymap({ "n", "v" }, "gh", "^", { desc = "Go to the beginning line" })
keymap({ "n", "v" }, "gl", "$", { desc = "Go to the end of the line" })

-- To keep ? or not ?
keymap({ "n", "v" }, "dh", "d^", { desc = "Delete to the beginning line" })
keymap({ "n", "v" }, "dl", "d$", { desc = "Delete to the end of the line" })
keymap({ "n", "v" }, "ch", "c^", { desc = "Delete and Insert to the beginning line" })
keymap({ "n", "v" }, "cl", "c$", { desc = "Delete and Insert to the end of the line" })

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
keymap("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
keymap("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
keymap("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
keymap("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
keymap("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
keymap("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
