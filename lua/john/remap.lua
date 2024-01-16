vim.g.mapleader = " "
local map = vim.keymap

-- Util remaps
map.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Keymap for netrw-:Explore" })
map.set("n", "J", "mzJ`z", { desc = "Concat line below but do not move cursor" })
map.set("i", "<C-c>", "<Esc>", { desc = "Control C acts like Escape in Insert Mode" })
map.set("n", "Q", "<nop>", { desc = "Disable Q" })
map.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux Sessionizer" })
map.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format with lsp" })
map.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true,  desc = "Make current file executable" })
map.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under cursor" })
map.set("n", "<leader>we", "<cmd>w | :Ex<CR>", { silent = true }, { desc = "Write and move to netrw-:Explore" })


-- Center on down/up
map.set("n", "<C-d>", "<C-d>zz", { desc = "Maintain centered cursor on page down" })
map.set("n", "<C-u>", "<C-u>zz", { desc = "Maintain centered cursor on page up" })

-- Center on next search item
map.set("n", "n", "nzzzv", { desc = "Center on next search item" })
map.set("n", "N", "Nzzzv", { desc = "Center on prev search item" })

-- greatest remap ever
map.set("x", "<leader>p", [["_dP]], { desc = "Delete a highlighted word into the void register and then paste over" })

-- next greatest remap ever : asbjornHaland
map.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank into clipboard register" })
map.set("n", "<leader>Y", [["+Y]], { desc = "Yank line into clipboard register" })
map.set({ "n", "v" }, "<leader>P", [["+p]], { desc = "Paste from clipboard" })

-- List Navigation
map.set("n", "]]", "<cmd>cnext<CR>zz", { desc = "Move to next in list" })
map.set("n", "[[", "<cmd>cprev<CR>zz", { desc = "Move to prev in list" })

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
