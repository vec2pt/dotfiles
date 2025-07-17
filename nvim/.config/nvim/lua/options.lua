--------------------------------------------------------------------------------
-- General settings
--------------------------------------------------------------------------------

-- UI
vim.opt.termguicolors = true -- Enable true color support
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "81"
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.confirm = true
vim.opt.inccommand = "split"
-- vim.opt.showmatch = true -- ?
-- vim.opt.matchtime = 2
-- vim.opt.completeopt = "menuone,noinsert,noselect" -- { "menu", "menuone", "noselect" }

-- Indentation
vim.opt.tabstop = 4       -- insert 4 spaces for a tab
vim.opt.softtabstop = 4   -- number of columns for a tab
vim.opt.shiftwidth = 4    -- the number of spaces inserted for each indentation
vim.opt.expandtab = true  -- convert tabs to whitespace
vim.opt.autoindent = true -- auto indentation
vim.opt.smartindent = true

-- Wrapped lines
vim.opt.breakindent = true -- Enable break indent
vim.opt.linebreak = true
vim.opt.showbreak = "↳"

-- Search
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true  -- unless capital letter in search
vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = true   -- do not highlight matches

-- File handling
vim.opt.swapfile = false
vim.opt.undofile = true -- Save undo history
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Behavior settings
vim.opt.encoding = "utf-8" -- (default)
vim.opt.mouse = "a"
vim.schedule(function() vim.opt.clipboard = "unnamedplus" end)
-- vim.opt.iskeyword:append("-")
-- vim.opt.path:append("**")
vim.opt.whichwrap:append("<,>,h,l,[,]")
-- vim.opt.virtualedit = "block"
-- vim.opt.autochdir = true
-- vim.opt.autowrite = true

-- Render whitespace
vim.opt.list = true
vim.opt.listchars = {
    tab            = "» ",
    trail          = "·",
    nbsp           = "␣",
    -- leadmultispace = "│   ",
    leadmultispace = " ",
    multispace     = "·",
    extends        = "→",
    precedes       = "←"
}

-- Scroll
vim.opt.scrolloff = 5     -- minimum number of lines to keep above and below the cursor
vim.opt.sidescrolloff = 5 -- minimum number of columns to keep above and below the cursor

-- Tabs
-- vim.opt.showtabline = 2

-- Split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Session
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Command-line completion
-- vim.opt.wildmenu = true
-- vim.opt.wildmode = "longest:full,full"
-- vim.opt.wildoptions = "fuzzy,pum,tagfile"

-- Performance improvements
-- vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Netrw (TODO)
-- https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0
vim.g.netrw_list_style = 3

--------------------------------------------------------------------------------
-- Filetype-specific settings
--------------------------------------------------------------------------------
-- TODO: use ftplugin

local augroup = vim.api.nvim_create_augroup("UserFileTypeSettings", {})

-- Indentation
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "c", "cpp", "arduino", "html", "svg", "xml", "css", "scss", "sass", "javascript" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
        -- vim.opt_local.listchars = {
        --     leadmultispace = "│ ",
        -- }
    end,
})

-- Spell Checking
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "markdown" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en,pl"
        vim.opt_local.spelloptions = "camel"
    end,
})
