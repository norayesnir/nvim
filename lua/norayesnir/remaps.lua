vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Reset unwanted keymaps
vim.keymap.set("", "q", "")
vim.keymap.set("", "gt", "")
vim.keymap.set("", "gT", "")

-- Reset window navigation
vim.keymap.set({ "n", "t" }, "<C-h>", "")
vim.keymap.set({ "n", "t" }, "<C-j>", "")
vim.keymap.set({ "n", "t" }, "<C-k>", "")
vim.keymap.set({ "n", "t" }, "<C-l>", "")

-- Reset terminal navigation
vim.keymap.set("t", "<C-w>", "<C-w>")

-- Remap macro record key
vim.keymap.set("n", "Q", "q")

-- Save, close, quit
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>wa", ":wa<CR>")
vim.keymap.set("n", "<leader>q", ":wq<CR>")
vim.keymap.set("n", "<leader>Q", ":q!<CR>")

-- Delete is not cut
vim.keymap.set({ "n", "x" }, "d", '"_d')
vim.keymap.set({ "n", "x" }, "D", '"_D')
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_X')

-- Cut using x
vim.keymap.set({ "n", "x" }, "x", "d")
vim.keymap.set("n", "xx", "dd")
vim.keymap.set({ "n", "x" }, "X", "D")

-- Move visual selection
vim.keymap.set("v", "K", ":m '<-2<CR>gv-gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv-gv")

-- Move pageup/down with centered cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep search terms in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Allows yank for use outside of nvim
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>Y", "\"+Y")

-- Delete a word backwards
vim.keymap.set("n", "db", 'vb"_d', { desc = "Delete a word backwards" })

-- Switch TMUX sessions
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Format code in buffer
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- Replace hovered word with %s/...
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Visual paste without yanking
vim.keymap.set("x", "p", '"_dP')

-- Enhance Enter
vim.keymap.set({ "n", "i" }, "<C-Enter>", function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_put({ "" }, "l", true, true)
    vim.api.nvim_win_set_cursor(0, { row + 1, col })
end)

vim.keymap.set({ "n", "i" }, "<S-C-Enter>", function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_put({ "" }, "l", false, true)
    vim.api.nvim_win_set_cursor(0, { row, col })
end)

-- Better ^
vim.keymap.set({ "n", "i", "v" }, "<C-h>", function()
    vim.cmd("normal! ^")
end, { desc = "Better ^" })

vim.keymap.set({ "n", "i", "v" }, "<C-S-h>", "<Home>")

-- Better $
vim.keymap.set({ "n", "v" }, "<C-l>", "g_", { desc = "Better $" })
vim.keymap.set("i", "<C-l>", "<End>", { desc = "Better $" })

-- Scroll window one line up/down (insert mode)
vim.keymap.set("i", "<C-e>", "<C-x><C-e>")
vim.keymap.set("i", "<C-y>", "<C-x><C-y>")

-- Undo
vim.keymap.set("", "<C-z>", function()
    vim.cmd("undo")
end, { desc = "Undo" })

-- Duplicate lines logic
local function duplicate_lines(direction)
    local startline = vim.fn.line("v")
    local endline = vim.fn.getcurpos()[2]

    if startline > endline then
        startline, endline = endline, startline
    end

    local texts = vim.api.nvim_buf_get_lines(0, startline - 1, endline, true)

    if direction == "up" then
        vim.api.nvim_buf_set_lines(0, endline, endline, true, texts)
    elseif direction == "down" then
        vim.api.nvim_buf_set_lines(0, startline, startline + 1, true, texts)
    end
end

-- Copy lines
vim.keymap.set("n", "<S-M-j>", ":copy.<CR>")
vim.keymap.set("n", "<S-M-k>", ":copy.-1<CR>")
vim.keymap.set("v", "<S-M-j>", ":copy.-v:count<CR>gv")
vim.keymap.set("v", "<S-M-k>", function()
    duplicate_lines("up")
end)

-- Open lazygit
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")
