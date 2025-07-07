vim.opt.encoding = "utf-8"
vim.opt.mouse = "a"                   -- Enable mouse mode
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
end)
-- vim.opt.autochdir = true

-- UI
vim.g.have_nerd_font = true
vim.opt.termguicolors = true -- Enable true color support
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = '81'
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.confirm = true
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor,c:ver25'

-- Indentation
vim.opt.tabstop = 4        -- insert 4 spaces for a tab
vim.opt.softtabstop = 4    -- number of columns for a tab
vim.opt.shiftwidth = 4     -- the number of spaces inserted for each indentation
vim.opt.expandtab = true   -- convert tabs to whitespace
vim.opt.autoindent = true  -- auto indentation
vim.opt.smartindent = true
vim.opt.breakindent = true -- Enable break indent

-- Visualizing whitespace
vim.opt.list = true -- show tab characters and trailing whitespace
vim.opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '␣',
    leadmultispace = "····",
    multispace = '·',
    extends = '→',
    precedes = '←'
}

-- Search
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true  -- unless capital letter in search
vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = true   -- do not highlight matches

-- Scroll
vim.opt.scrolloff = 5     -- minimum number of lines to keep above and below the cursor
vim.opt.sidescrolloff = 5 -- minimum number of columns to keep above and below the cursor
-- vim.opt.inccommand = 'split'
-- vim.opt.showtabline = 2

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- History
vim.opt.undofile = true -- Save undo history

-- Decrease update time
vim.opt.updatetime = 250



-- Session
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

--------------------------------------------------------------------------------

-- Menu
-- vim.opt.wildmenu = true
-- vim.opt.wildoptions = 'fuzzy,pum,tagfile'


-- https://superuser.com/questions/431233/vim-shortcut-to-move-to-beginning-of-next-line-end-of-previous-line
-- vim.opt.whichwrap:append('<,>,h,l,[,]')

-- Wrap
-- vim.opt.breakindent = true
-- vim.opt.linebreak = true
-- vim.opt.whichwrap = 'h,l,<,>,[,],~'
-- vim.opt.breakindentopt = 'shift:2,min:20'
-- vim.opt.showbreak = '↳ '

-- Folding
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 1
-- vim.opt.foldlevel = 8
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldmethod = 'syntax'
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Python
-- vim.g.python3_host_prog = os.getenv("HOME") .. '/virtualenvs/nvim-venv/bin/python'

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
-- vim.opt.timeoutlen = 300

-- Preview substitutions live, as you type!
-- vim.o.inccommand = 'split'

-- Spell Checking
-- vim.opt.spell = true
-- vim.opt.spelllang = "en,pl"
-- vim.opt.spelloptions = 'camel'

-- vim.opt.fixendofline = false
-- vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- vim.opt.virtualedit = "block"
-- vim.opt.wildignorecase = true
-- vim.opt.infercase = true
