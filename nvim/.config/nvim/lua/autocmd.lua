-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Return to last edit position when opening files",
    group = vim.api.nvim_create_augroup('ReturnToLastEditPosition', {}),
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd('normal! g`"')
        end
    end,
})

-- Cleanup on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    desc = "Cleanup on save",
    group = vim.api.nvim_create_augroup('CleanupOnSave', {}),
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        -- Removes trailing spaces & Remove blank lines at end of file
        -- https://vi.stackexchange.com/questions/44204/remove-blank-lines-at-end-of-file
        vim.cmd([[%s/\s\+$//e|%s/\_s*\%$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Create directories when saving files",
    group = vim.api.nvim_create_augroup("CreateDirWhenSaving", {}),
    callback = function()
        local dir = vim.fn.expand('<afile>:p:h')
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end,
})

--------------------------------------------------------------------------------

-- Session management
-- https://aymanbagabas.com/blog/2023/04/13/simple-vim-session-management.html
-- BUG with Netrw?

local session_management_augroup = vim.api.nvim_create_augroup('SessionManagement', {})

vim.api.nvim_create_autocmd("VimEnter", {
    desc = "Session management: Create new / Open existing session",
    group = session_management_augroup,
    callback = function(data)
        local isdirectory = vim.fn.isdirectory(data.file) == 1
        if not isdirectory then return end

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
    desc = "Session management: Save session",
    group = session_management_augroup,
    callback = function()
        if not vim.g.save_session then return end

        local sessionfile = ".nvim/Session.vim"
        if vim.v.this_session ~= "" then
            sessionfile = vim.v.this_session
        end

        vim.fn.mkdir(".nvim", "p")
        vim.cmd("mksession! " .. sessionfile)
    end,
})

--------------------------------------------------------------------------------

-- (Temporary) AutoFormat fir Ruff - https://docs.astral.sh/ruff/formatter/#sorting-imports

local autoformat_augroup = vim.api.nvim_create_augroup('AutoFormat', {})

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Ruff format on seve.",
    pattern = "*.py",
    group = autoformat_augroup,
    callback = function()
        vim.cmd("silent !ruff check --select I --fix %")
        vim.cmd("silent !ruff format --line-length 80 %")
        -- vim.cmd("edit")
    end,
})
