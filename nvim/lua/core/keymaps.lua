vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- Paste in insert mode
keymap.set("i", "<C-v>", '<C-r>"')

-- general keymaps
keymap.set("i", "jj", "<ESC>")
keymap.set("i", "<C-s>", "<ESC>:w<CR>")
keymap.set("n", "<C-s>", ":w<CR>")
keymap.set("n", "<CR>", ":nohl<CR>")
keymap.set("n", "x", '"_x')
keymap.set("n", "<C-e>", ":bnext<CR>")
keymap.set("n", "<C-q>", ":bprev<CR>")
keymap.set("n", "<leader>q", ":Bdelete<CR>")
keymap.set("n", "<C-n>", ":Neotree toggle<CR>") -- nvim tree toggle
keymap.set("n", "<leader>e", ":Neotree reveal<cr>")
keymap.set("i", "<C-j>", "<enter>")
keymap.set("i", "<C-v>", '<esc>"+pi')
keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
-- keymap.set("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>")
keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
-- vim.cmd([[
-- nnoremap <silent><leader>q :<C-U>bprevious <bar> bdelete #<CR>
-- ]])

-- telescope
--local builtin = require("telescope.builtin")
keymap.set("n", "<C-p>", ":Telescope find_files<cr>")           -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")   -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")     -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")   -- list available help tags
--vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
