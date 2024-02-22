local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- Define a custom function to delete word before cursor
local function delete_word_before_cursor()
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<C-w>", true, false, true),
        "i",
        true
    )
end

-- Bind the custom function to <M-BS> in insert mode specifically for 
-- Telescope file select UI
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                -- Override the <M-BS> mapping to delete word before cursor
                ["<M-BS>"] = function(prompt_bufnr)
                    delete_word_before_cursor()
                end
            }
        }
    }
}

