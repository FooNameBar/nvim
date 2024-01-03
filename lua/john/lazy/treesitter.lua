-- Treesitter and addons --
return {
    "nvim-treesitter/playground",

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer 'require("nvim-treesitter")', which
        -- no longer trigger the **nvim-treesitter** module to be loaded in time.
        -- Luckily, the only things those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall"},
    opts =  {
        -- A list of parser names, or "all"
        ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust" },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        highlight = { enable = true, },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
    },
 },

 -- Treesitter Context
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = true,
        opts = {
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
            trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20,     -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        },
        config = function()
            vim.cmd('hi TreesitterContextBottom gui=underline guisp=Grey')
            vim.keymap.set("n", "<leader>tc", function()
                    local Util = require("lazyvim.util")
                    local tsc = require("treesitter-context")
                    tsc.toggle()
                    if Util.inject.get_upvalue(tsc.toggle, "enabled") then
                        Util.info("Enabled Treesitter Context", { title = "Option" })
                    else
                        Util.warn("Disabled Treesitter Context", { title = "Option" })
                    end
            end)
        end,
    },

    -- Treesitter Textobjects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
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
                    },
                    swap_previous = {
                        ["<leader>sP"] = "@parameter.inner",
                        ["<leader>sF"] = "@function.outer",
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
                },
            },
        },
        config = function()

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
        end,
    },
}
