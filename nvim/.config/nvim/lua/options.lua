--------------------------------------------------------------------------------
-- General settings
--------------------------------------------------------------------------------

-- UI
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "81"
vim.opt.signcolumn = "yes"
vim.opt.confirm = true
vim.opt.inccommand = "split"
-- vim.opt.showmatch = true -- ?
-- vim.opt.matchtime = 2

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftround = true

-- Wrapped lines
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.showbreak = "↳"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- File handling
vim.opt.swapfile = false
vim.opt.undofile = true
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
vim.opt.autowrite = true

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
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

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
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Command-line completion
-- vim.opt.wildmenu = true
-- vim.opt.wildmode = "longest:full,full"
-- vim.opt.wildoptions = "fuzzy,pum,tagfile"

-- Insert mode completion
-- vim.opt.completeopt = "menuone,noinsert,noselect" -- { "menu", "menuone", "noselect" }

-- Performance improvements
-- vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Netrw (TODO)
-- https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- Disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

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
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "markdown" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en,pl"
        vim.opt_local.spelloptions = "camel"
    end,
})
