return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {}
                }
            }
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

            vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = 'Telescope jumplist' })
            vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Lists LSP document symbols' })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Lists Diagnostics' })
            vim.keymap.set("n", "<leader>co", function()
                require('telescope.builtin').find_files {
                    cwd = vim.fn.stdpath("config")
                }
            end, { desc = "Config open" })
            require('telescope').load_extension('fzf')
        end
    },

}
