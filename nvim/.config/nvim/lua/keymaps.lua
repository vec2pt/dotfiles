vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------------------

-- Clear highlights on search
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Quick Esc
-- vim.keymap.set("i", "jj", "<Esc>", { noremap = false })
-- vim.keymap.set("i", "jk", "<Esc>", { noremap = false })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resizing
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", "<Cmd>m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<Cmd>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", "<Cmd>m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", "<Cmd>m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Splitting
-- Use "CTRL-W s" and "CTRL-W v"
-- vim.keymap.set("n", "<Leader>sv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
-- vim.keymap.set("n", "<Leader>sh", "<Cmd>split<CR>", { desc = "Split window horizontally" })

-- Buffers
-- vim.keymap.set("n", "<Leader>bn", "<Cmd>bnext<CR>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<Leader>bp", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<Leader>bx", "<Cmd>%bd|e#|bd#<CR>",
    { desc = "Close All Buffers Except the Current One" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Quickfix
-- vim.keymap.set("n", "<A-j>", "<Cmd>cnext<CR>", { desc = "Quickfix next" })
-- vim.keymap.set("n", "<A-k>", "<Cmd>cprev<CR>", { desc = "Quickfix previous" })

--------------------------------------------------------------------------------

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")

local terminal_state = { buf = nil, win = nil }

local function toggle_terminal()
    -- If terminal is already open, close it (toggle behavior)
    if terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        -- TODO ??
        -- vim.api.nvim_win_hide(terminal_state.win)
        return
    end


    -- Create buffer if it doesn't exist or is invalid
    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
        terminal_state.buf = vim.api.nvim_create_buf(false, true)
    end

    -- Create the window
    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
        split = "below",
        height = 10,
    })

    -- Start terminal if not already running
    if vim.bo[terminal_state.buf].buftype ~= "terminal" then
        vim.cmd.terminal()
    end
end

vim.keymap.set("n", "<Leader>tt", toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })


--------------------------------------------------------------------------------

-- Explore
vim.keymap.set("n", "<Leader>te", "<Cmd>Lexplore<CR>", { desc = "Toggle file explorer" })

-- Find
-- TODO: "<Cmd>find"

-- Config
-- vim.keymap.set("n", "<Leader>cr", "<Cmd>luafile $MYVIMRC<CR>", { desc = "Config reload" })

-- Diagnostic keymaps
vim.keymap.set("n", "<Leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<Leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Toggle
vim.keymap.set("n", "<Leader>tw", "<Cmd>set wrap!<CR>", { desc = "Toggle line wrap" })
vim.keymap.set("n", "<Leader>ts", "<Cmd>set spell!<CR>", { desc = "Toggle spell" })

--------------------------------------------------------------------------------

-- Disable arrow keys (add "c" mode ?)
vim.keymap.set({ "n", "i", "v" }, "<left>", "<Cmd>echo 'Use h to move!!'<CR>")
vim.keymap.set({ "n", "i", "v" }, "<right>", "<Cmd>echo 'Use l to move!!'<CR>")
vim.keymap.set({ "n", "i", "v" }, "<up>", "<Cmd>echo 'Use k to move!!'<CR>")
vim.keymap.set({ "n", "i", "v" }, "<down>", "<Cmd>echo 'Use j to move!!'<CR>")
