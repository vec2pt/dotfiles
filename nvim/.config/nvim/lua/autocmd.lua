-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then vim.cmd("normal! g`\"") end
    end
})

-- Removes trailing spaces
vim.api.nvim_create_autocmd({"BufWritePre"}, {pattern = {"*"}, command = [[%s/\s\+$//e]]})

-- Removes trailing spaces
vim.api.nvim_create_autocmd({"BufWritePre"}, {pattern = {"*"}, command = [[%s/\_s*\%$//e]]})

-- AutoFormat
vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.py",
    group = "AutoFormat",
    callback = function()
        vim.cmd("silent !ruff check --select I --fix --quiet %")
        vim.cmd("silent !ruff format --quiet %")
        vim.cmd("edit")
    end
})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.sh",
    group = "AutoFormat",
    callback = function()
        vim.cmd("silent !shfmt -i 4 -w %")
        vim.cmd("edit")
    end
})
