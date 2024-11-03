vim.g.have_nerd_font = true
vim.opt.encoding = "utf-8"
vim.opt.termguicolors = true -- enable true color support
vim.opt.mouse = 'a' -- Enable mouse mode
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
-- vim.opt.showmode = true
vim.opt.autochdir = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.cursorline = true
-- vim.opt.cursorlineopt = 'number'
vim.opt.wrap = false
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default

-- Tabs / spaces / list / eol
vim.opt.tabstop = 4 -- insert 4 spaces for a tab
vim.opt.softtabstop = 4 -- number of columns for a tab
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.autoindent = true -- auto indentation
vim.opt.list = true -- show tab characters and trailing whitespace
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', leadmultispace = "····", multispace = '·'}
vim.opt.fixendofline = false

-- Search
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- unless capital letter in search
vim.opt.hlsearch = false -- do not highlight all matches on previous search pattern
vim.opt.incsearch = true -- incrementally highlight searches as you type

-- Scroll
vim.opt.scrolloff = 10 -- minimum number of lines to keep above and below the cursor
vim.opt.sidescrolloff = 10 --minimum number of columns to keep above and below the cursor

-- Splits / Tabs
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.showtabline = 2

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Menu
vim.opt.wildmenu=true
-- vim.opt.wildmode='list:longest'
vim.opt.wildoptions='fuzzy,pum,tagfile'


-- https://superuser.com/questions/431233/vim-shortcut-to-move-to-beginning-of-next-line-end-of-previous-line
vim.opt.whichwrap:append('<,>,h,l,[,]')

-- python code environment
-- vim.g.python3_host_prog = os.getenv("HOME") .. '/virtualenvs/nvim-venv/bin/python'

-- Decrease update time
-- vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
-- vim.opt.timeoutlen = 300
