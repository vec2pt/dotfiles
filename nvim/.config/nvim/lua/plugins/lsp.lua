return {
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        build = "cargo build --release",
        opts = {
            keymap = { preset = "default" },
            -- keymap = { preset = "super-tab" },
            completion = { documentation = { auto_show = true } },
            signature = { enabled = true },
            cmdline = {
                keymap = { preset = "inherit" },
                completion = { menu = { auto_show = true } },
            },
        },
        opts_extend = { "sources.default" }
    },
    {

        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp",
            {
                "folke/lazydev.nvim",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            }, },
        config = function()
            vim.lsp.enable("lua_ls") -- Lua
            -- vim.lsp.config("lua_ls", {
            --     settings = {
            --         Lua = {
            --             runtime = {
            --                 version = "LuaJIT", },
            --             diagnostics = { globals = { "vim", "require" },
            --             },
            --             workspace = { library = vim.api.nvim_get_runtime_file("", true), },
            --             telemetry = { enable = false, },
            --         },
            --     },
            -- })
            vim.lsp.enable({ "pyright", "ruff" })         -- Python
            vim.lsp.enable("bashls")                      -- Bash
            vim.lsp.enable({ "html", "cssls", "jsonls" }) -- HTML / CSS / Json
            vim.lsp.config("jsonls", {
                init_options = { provideFormatter = false }
            })
            vim.lsp.enable("rust_analyzer") -- Rust
            vim.lsp.enable("clangd")        -- C / C++
            vim.lsp.enable("yamlls")        -- YAML

            -- :h lsp-format
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-augroup", {}),
                callback = function(args)
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                    if client:supports_method('textDocument/implementation') then
                        vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = args.buf, desc = "LSP: [R]e[n]ame" })
                        vim.keymap.set({ "n", "x" }, "gra", vim.lsp.buf.code_action,
                            { buffer = args.buf, desc = "LSP: [G]oto Code [A]ction" })
                        vim.keymap.set("n", "grD", vim.lsp.buf.declaration,
                            { buffer = args.buf, desc = "LSP: [G]oto [D]eclaration" })
                        vim.keymap.set("n", "grf", vim.lsp.buf.format,
                            { buffer = args.buf, desc = "LSP: [F]ormat" })

                        -- fzf-lua keymaps
                        local builtin = require("fzf-lua")
                        vim.keymap.set("n", "grr", builtin.lsp_references,
                            { buffer = args.buf, desc = "LSP: [G]oto [R]eferences" })
                        vim.keymap.set("n", "gri", builtin.lsp_implementations,
                            { buffer = args.buf, desc = "LSP: [G]oto [I]mplementation" })
                        vim.keymap.set("n", "grd", builtin.lsp_definitions,
                            { buffer = args.buf, desc = "LSP: [G]oto [D]efinition" })
                        vim.keymap.set("n", "gO", builtin.lsp_document_symbols,
                            { buffer = args.buf, desc = "LSP: Open Document Symbols" })
                        vim.keymap.set("n", "gW", builtin.lsp_workspace_symbols,
                            { buffer = args.buf, desc = "LSP: Open Workspace Symbols" })
                        vim.keymap.set("n", "grt", builtin.lsp_typedefs,
                            { buffer = args.buf, desc = "LSP: [G]oto [T]ype Definitions" })

                        -- Telescope keymaps
                        -- local builtin = require("telescope.builtin")
                        -- vim.keymap.set("n", "grr", builtin.lsp_references,
                        --     { buffer = args.buf, desc = "LSP: [G]oto [R]eferences" })
                        -- vim.keymap.set("n", "gri", builtin.lsp_implementations,
                        --     { buffer = args.buf, desc = "LSP: [G]oto [I]mplementation" })
                        -- vim.keymap.set("n", "grd", builtin.lsp_definitions,
                        --     { buffer = args.buf, desc = "LSP: [G]oto [D]efinition" })
                        -- vim.keymap.set("n", "gO", builtin.lsp_document_symbols,
                        --     { buffer = args.buf, desc = "LSP: Open Document Symbols" })
                        -- vim.keymap.set("n", "gW", builtin.lsp_dynamic_workspace_symbols,
                        --     { buffer = args.buf, desc = "LSP: Open Workspace Symbols" })
                        -- vim.keymap.set("n", "grt", builtin.lsp_type_definitions,
                        --     { buffer = args.buf, desc = "LSP: [G]oto [T]ype Definitions" })
                    end

                    -- Enable auto-completion
                    -- Optional: trigger autocompletion on EVERY keypress. May be slow!
                    -- if client:supports_method("textDocument/completion") then
                    --     local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
                    --     client.server_capabilities.completionProvider.triggerCharacters = chars
                    --     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
                    -- end

                    -- Auto-format ("lint") on save.
                    if not client:supports_method("textDocument/willSaveWaitUntil")
                        and client:supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("lsp-augroup-autoformat", { clear = false }),
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                            end,
                        })
                    end

                    -- Enable highlight `:help CursorHold`
                    if client:supports_method("textDocument/documentHighlight") then
                        local highlight_augroup = vim.api.nvim_create_augroup("lsp-augroup-highlight",
                            { clear = false })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = args.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = args.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup("lsp-augroup-detach", { clear = true }),
                            callback = function(args2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = "lsp-augroup-highlight", buffer = args2.buf }
                            end,
                        })
                    end

                    -- Diagnostic Config
                    -- See :help vim.diagnostic.Opts
                    vim.diagnostic.config {
                        severity_sort = true,
                        float = { border = "solid", source = "if_many" },
                        -- underline = { severity = vim.diagnostic.severity.ERROR },
                        signs = {
                            text = {
                                [vim.diagnostic.severity.ERROR] = "󰅚 ",
                                [vim.diagnostic.severity.WARN] = "󰀪 ",
                                [vim.diagnostic.severity.INFO] = "󰋽 ",
                                [vim.diagnostic.severity.HINT] = "󰌶 ",
                            },
                        } or {},
                        virtual_text = false,
                        -- virtual_text = {
                        --     source = "if_many",
                        --     spacing = 2,
                        --     format = function(diagnostic)
                        --         local diagnostic_message = {
                        --             [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        --             [vim.diagnostic.severity.WARN] = diagnostic.message,
                        --             [vim.diagnostic.severity.INFO] = diagnostic.message,
                        --             [vim.diagnostic.severity.HINT] = diagnostic.message,
                        --         }
                        --         return diagnostic_message[diagnostic.severity]
                        --     end,
                        -- },
                    }
                end,
            })
        end,
    }
}
