local telescope = require('telescope')

telescope.setup {
    extentions = {
        file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            mappings = {
                ["i"] = {
                    -- Insert mode mappings
                },
                ["n"] = {
                    -- Normal mode mappings
                    vim.keymap.set("n", "<leader>e", ":Telescope file_browser<CR>")
                }
            }
        }
    }
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")})
end)
