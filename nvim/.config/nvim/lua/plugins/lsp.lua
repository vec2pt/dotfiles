-- Source: https://lsp-zero.netlify.app/docs/guide/lazy-loading-with-lazy-nvim.html
-- LSP Info: https://www.andersevenrud.net/neovim.github.io/lsp/configurations/

return {

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = { 'hrsh7th/cmp-nvim-lsp-signature-help', "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" },
        event = 'InsertEnter',
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                sources = { { name = 'nvim_lsp' }, { name = 'nvim_lsp_signature_help' }, { name = 'buffer' }, { name = 'path' } },
                mapping = cmp.mapping.preset.insert({
                    -- ['<C-Space>'] = cmp.mapping.complete(),
                    -- ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    -- ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item()
                }),
                snippet = { expand = function(args) vim.snippet.expand(args.body) end }
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { { 'hrsh7th/cmp-nvim-lsp' } },
        init = function()
            -- Reserve a space in the gutter
            -- This will avoid an annoying layout shift in the screen
            vim.opt.signcolumn = 'yes'
        end,
        config = function()
            local lsp_defaults = require('lspconfig').util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities())

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                end
            })

            -- These are just examples. Replace them with the language
            -- servers you have installed in your system

            -- Python
            -- require('lspconfig').ruff.setup({})
            require('lspconfig').pyright.setup({})

            -- Lua
            -- require('lspconfig').lua_ls.setup({})
            -- https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
            require('lspconfig').lua_ls.setup {
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {
                                'vim',
                                'require'
                            },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }

            -- HTML/CSS/JSON/ESLint
            require('lspconfig').html.setup {}
            require('lspconfig').cssls.setup {}
            require('lspconfig').jsonls.setup {}

            -- Rust
            require('lspconfig').rust_analyzer.setup {}

            -- C/C++
            require('lspconfig').clangd.setup {}

            -- YAML
            require 'lspconfig'.yamlls.setup {}
        end
    }
}
