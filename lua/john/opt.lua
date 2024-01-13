vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local opt = vim.opt

-- Lazy options
opt.autowrite = true                               -- Write a modified buffer on events
opt.backup = false                                 -- No backup when overwriting file
opt.colorcolumn = "80"
opt.completeopt = "menu,menuone,noinsert,noselect" -- menu cmp options
opt.conceallevel = 3                               -- Hide * markup for bold and italic
opt.confirm = true                                 -- Confirm to save changes before exiting modified buffer
opt.cursorline = true                              -- Enable highlighting of the current line
opt.expandtab = true                               -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt"                     -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.guicursor = ""
opt.hlsearch = false       -- Do not highlight previous matches
opt.incsearch = true       -- Show match of current pattern
opt.isfname:append("@-@")
opt.ignorecase = true      -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3         -- global statusline
opt.list = true            -- Show some invisible characters (tabs...
opt.number = true          -- Show line numbers
opt.pumblend = 10          -- Popup blend
opt.pumheight = 10         -- Maximum number of entries in a popup
opt.relativenumber = true  -- Relative line numbers
opt.scrolloff = 10         -- Lines to maintain at top/bottom
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true      -- Round indent
opt.shiftwidth = 4
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false   -- Dont show mode since we have a statusline
opt.sidescrolloff = 10 -- Columns of context
opt.signcolumn = "yes"
opt.smartcase = true   -- Don't ignore case with capitals for searches
opt.smartindent = true -- Insert indents automatically
opt.smoothscroll = true
opt.spelllang = { "en" }
opt.softtabstop = 4
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 500
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
