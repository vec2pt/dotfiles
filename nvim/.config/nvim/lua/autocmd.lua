-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Return to last edit position when opening files",
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd('normal! g`"')
        end
    end,
})

-- Removes trailing spaces
-- https://vi.stackexchange.com/questions/37421/how-to-remove-neovim-trailing-white-space
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    desc = "Removes trailing spaces",
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Insert final newline
-- https://www.reddit.com/r/neovim/comments/11269m2/newline_at_the_end/
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    desc = "Insert final newline",
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\n*\%$/\r/e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Session management
-- https://aymanbagabas.com/blog/2023/04/13/simple-vim-session-management.html
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(data)
        local isdirectory = vim.fn.isdirectory(data.file) == 1
        if not isdirectory then
            return
        end

        vim.g.save_session = false

        for _, root in ipairs({ ".git", ".hg", ".bzr", ".svn", ".nvim" }) do
            if vim.fn.isdirectory(data.file .. "/" .. root) == 1 then
                vim.g.save_session = true
                break
            end
        end

        if vim.g.save_session then
            local sessionfile = vim.fn.resolve(data.file .. "/.nvim/Session.vim")
            if vim.fn.filereadable(sessionfile) == 1 then
                vim.cmd("source " .. sessionfile)
            end
        end

        -- wipe the directory buffer
        vim.cmd("bw " .. data.buf)
    end,
    nested = true,
})

vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        if not vim.g.save_session then
            return
        end

        local sessionfile = ".nvim/Session.vim"
        if vim.v.this_session ~= "" then
            sessionfile = vim.v.this_session
        end

        vim.fn.mkdir(".nvim", "p")
        vim.cmd("mksession! " .. sessionfile)
    end,
})
