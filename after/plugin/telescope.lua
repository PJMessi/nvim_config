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
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
        }
    }
}

require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")

vim.api.nvim_set_keymap(
  "n",
  "<space>fb",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)
