require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

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
