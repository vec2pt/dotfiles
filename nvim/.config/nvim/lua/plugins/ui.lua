return {

    -- Color scheme
    {
        'navarasu/onedark.nvim',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function() require('onedark').load() end
    },

    -- Icons
    {'nvim-tree/nvim-web-devicons', config = function() require('nvim-web-devicons').setup {color_icons = false} end},

    -- Statusline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function()
            require('lualine').setup {options = {theme = 'onedark', section_separators = '', component_separators = ''}}
        end
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require("nvim-treesitter.configs").setup {
                -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                ensure_installed = {
                    "c", "cpp", "make", "rust", "lua", "vim", "vimdoc", "gitignore", "markdown", "python", "bash",
                    "html", "css", "scss", "xml", "yaml", "json", "toml"
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                auto_install = false,
                highlight = {enable = true, additional_vim_regex_highlighting = false},
                indent = {enable = true}
            }
        end
    },

    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("nvim-tree").setup {}
            vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")
        end
    },

    -- Visualize buffers as tabs
    {
        'romgrk/barbar.nvim',
        dependencies = {
            -- 'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons' -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {animation = false, auto_hide = false, tabpages = true, clickable = true}
    }

}
