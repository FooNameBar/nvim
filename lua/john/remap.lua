vim.g.mapleader = " "
local map = vim.keymap

-- Project View
map.set("n", "<leader>pv", vim.cmd.Ex)

-- Concat line below but do not move cursor
map.set("n", "J", "mzJ`z")

-- Maintain centered cursor on page down/up
map.set("n", "<C-d>", "<C-d>zz")
map.set("n", "<C-u>", "<C-u>zz")

-- Center on next search item
map.set("n", "n", "nzzzv")
map.set("n", "N", "Nzzzv")

-- greatest remap ever
-- delete a highlighted word into the void register and then paste over
-- preserving the paste register
map.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- Yank into clipboard register
map.set({ "n", "v" }, "<leader>y", [["+y]])
map.set("n", "<leader>Y", [["+Y]]) -- Yank line into clipboard
map.set({ "n", "v" }, "<leader>P", [["+p]]) -- Paste from clipboard
map.set("v", "<leader>D", [["+d]])

-- This is going to get me cancelled
map.set("i", "<C-c>", "<Esc>")

map.set("n", "Q", "<nop>")
map.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
map.set("n", "<leader>f", vim.lsp.buf.format)

-- Move to next/prev list
map.set("n", "]]", "<cmd>cnext<CR>zz")
map.set("n", "[[", "<cmd>cprev<CR>zz")

map.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

map.set("n", "<leader>we", "<cmd>w | :Ex<CR>", { silent = true })

-- Lazy Keymap.sets
-- Resize window using <ctrl> arrow keys
map.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- windows
map.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- Move Lines
map.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Clear search with <esc>
map.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })


-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map.set( "n", "<leader>cu", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- Add undo break-points
map.set("i", ",", ",<c-g>u")
map.set("i", ".", ".<c-g>u")
map.set("i", ";", ";<c-g>u")

-- save file
map.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map.set("v", "<", "<gv")
map.set("v", ">", ">gv")

-- lazy
map.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
