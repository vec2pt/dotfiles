return {
    {
        "ibhagwan/fzf-lua",
        enabled = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            { "fzf-native", "hide" }
        },
        config = function()
            require("fzf-lua").setup { winopts = { split = "belowright new" } }
            local builtin = require("fzf-lua")
            vim.keymap.set("n", "<leader>ff", builtin.files, { desc = "FZF find files" })

            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "FZF live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "FZF buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "FZF help tags" })

            vim.keymap.set("n", "<leader>fj", builtin.jumps, { desc = "FZF jumplist" })
            vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Lists LSP document symbols" })
            vim.keymap.set("n", "<leader>dl", builtin.diagnostics_document, { desc = "Lists Diagnostics" })

            vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "FZF keymaps" })
            vim.keymap.set("n", "<leader>fw", builtin.grep_cword, { desc = "FZF search current word" })
            vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "FZF resume" })
            vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "FZF recent files" })
            vim.keymap.set("n", "<leader>f/", builtin.lgrep_curbuf,
                { desc = "FZF search in current buffer" })

            vim.keymap.set("n", "<leader>fc", function()
                builtin.files {
                    cwd = vim.fn.stdpath("config")
                }
            end, { desc = "FZF search in Neovim config" })
        end,
    }
}
