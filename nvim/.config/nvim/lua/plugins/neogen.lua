return {
    {
        "danymat/neogen",

        config = function()
            require('neogen').setup {
                enabled = true,             --if you want to disable Neogen
            }
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
            vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
            vim.api.nvim_set_keymap("n", "<Leader>nt", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)
            vim.api.nvim_set_keymap("n", "<Leader>nd", ":lua require('neogen').generate({ type = 'file' })<CR>", opts)
        end
    }
}
