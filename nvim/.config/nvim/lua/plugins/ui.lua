return {

    -- Color scheme
    {
        "navarasu/onedark.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- require("onedark").setup { style='light' }
            require("onedark").load()
        end
    },

    -- Icons
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({ color_icons = false })
        end,
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = { theme = "onedark", section_separators = "", component_separators = "" },
            })
            vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
        end,
    },

    -- Indentation
    {
        "nvimdev/indentmini.nvim",
        config = function()
            require("indentmini").setup()
            vim.cmd.highlight('IndentLine guifg=#353b45')
            vim.cmd.highlight('IndentLineCurrent guifg=#565c64')
        end
    },
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     main = "ibl",
    --     opts = {},
    -- }

    -- Highlight todo, notes, etc in comments
    -- {
    --     'folke/todo-comments.nvim',
    --     event = 'VimEnter',
    --     dependencies = { 'nvim-lua/plenary.nvim' },
    --     opts = {
    --         signs = false
    --     },
    -- }
}
