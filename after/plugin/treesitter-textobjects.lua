require('nvim-treesitter.configs').setup {
    textobjects = {
        select = {
            enable = true,
            lookahed = true,

            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ab'] = '@block.outer',
                ['ib'] = '@block.inner',
            }
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>sp"] = "@parameter.inner",
                ["<leader>sf"] = "@function.outer",
                ["<leader>sc"] = "@conditional.outer",
            },
            swap_previous = {
                ["<leader>sP"] = "@parameter.inner",
                ["<leader>sF"] = "@function.outer",
                ["<leader>sC"] = "@conditional.outer",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']f'] = '@function.outer',
                [']c'] = '@class.outer'
            },
            goto_next_end = {
                ['[F'] = '@function.outer',
                [']C'] = '@class.outer'
            },
            goto_previous_start = {
                ['[f'] = '@function.outer',
                ['[c'] = '@class.outer'
            },
            goto_previous_end = {
                ['[F'] = '@function.outer',
                ['[C'] = '@class.outer'
            },

            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            goto_next = {
                ["]i"] = "@conditional.outer",
            },
            goto_previous = {
                ["[i"] = "@conditional.outer",

            },
        },
    },
}

local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
-- vim.keymap.set()
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
