require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

-- tmux-aware split/pane nav — overrides nvchad.mappings C-hjkl (<C-w>hjkl)
-- note: no <C-U> inside <cmd> — keycodes are translated to raw control bytes
-- before <cmd> extracts the Ex command, so it becomes a literal ^U command
-- prefix ("Not an editor command: ^UTmuxNavigateLeft"); <cmd> never enters
-- the cmdline, so there is no range to clear anyway
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "navigate left (tmux aware)", silent = true })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "navigate down (tmux aware)", silent = true })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "navigate up (tmux aware)", silent = true })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "navigate right (tmux aware)", silent = true })
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "previous pane (tmux aware)", silent = true })

-- Visual mode: move selected lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move line up" })

-- Center cursor after half-page scrolls
map("n", "<C-d>", "<C-d>zz", {
	desc = "scroll down and center",
})
map("n", "<C-u>", "<C-u>zz", {
	desc = "scroll up and center",
})
map("n", "<C-o>", "<C-o>zz", { desc = "jump back and center" })
map("n", "<C-i>", "<C-i>zz", { desc = "jump forward and center" })

-- nvim-dap
map("n", "<F5>", function()
	require("dap").continue()
end, { desc = "debug continue/start" })
map("n", "<F10>", function()
	require("dap").step_over()
end, { desc = "debug step over" })
map("n", "<F11>", function()
	require("dap").step_into()
end, { desc = "debug step into" })
map("n", "<F12>", function()
	require("dap").step_out()
end, { desc = "debug step out" })
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "debug toggle breakpoint" })
map("n", "<leader>du", function()
	-- require dap first: requiring dapui cold loads nvim-dap-ui → its module
	-- requires dap → runs configs/dap.lua → requires dapui again mid-load = loop
	require("dap")
	require("dapui").toggle()
end, { desc = "debug toggle ui" })
