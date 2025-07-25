return {
    {
        "folke/trouble.nvim",
        opts = { },
        config = function()
            require("trouble").setup{
                focus = true,
                auto_jump = true,
                win = {
                    type = "split",
                    size = {
                        height = 25,
                    },
                },
                preview = {
                    type = "split",
                    relative = "win",
                    position = "right",
                    size = 0.5,
                },
                filter = {
                    any = {
                        buf = 0, -- current buffer
                        {
                            severity = vim.diagnostic.severity.ERROR, -- errors only
                            -- limit to files in the current project
                            function(item)
                                return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                            end,
                        },
                    },
                },
            }
            -- NOTE: diagnostics are not exclusive to lsp servers
            -- so these can be global keybindings
            vim.keymap.set("n", "<leader>wd", "<cmd>Trouble diagnostics toggle focus=true<cr>", { desc = "Trouble view diagnostics" })
        end,
    },
    -- Finds and lists all of the TODO, HACK, BUG, etc comment
    -- in your project and loads them into a browsable list.
    -- TODO: this is a test
    -- PERF: fully optimised
    -- HACK: looks a bit funky
    -- NOTE: adding a note
    -- FIX: needs fixing
    -- WARNING: ???
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "VeryLazy",
        opts = {},
        config = function()
            require("todo-comments").setup()
            vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>",                              { desc = "Todo (Trouble)" })
            vim.keymap.set("n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      { desc = "Todo/Fix/Fixme (Trouble)" })
            vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>",                            { desc = "Todo"  })
            vim.keymap.set("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    { desc = "Todo/Fix/Fixme"  })
        end,
    },
}
