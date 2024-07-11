return {
    {
        "folke/trouble.nvim",
        opts = { use_diagnostics_signs = true },
        config = function()
            local t = require("trouble")
            local noErr = "Vim:E42: No Errors"
            t.setup()
            -- NOTE: diagnostics are not exclusive to lsp servers
            -- so these can be global keybindings
            vim.keymap.set("n", "<leader>wd", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble view diagnostics" })
            vim.keymap.set("n", "]d", function()
                if t.is_open() then
                    t.next({ skip_groups = true, jump = true })
                elseif vim.diagnostic.get_next_pos({ wrap = true}) then
                    vim.diagnostic.goto_next({ wrap = true })
                else
                    local ok, err = pcall(vim.cmd.cnext)
                    if not ok and err ~= noErr then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end, { desc = "Trouble next item (quickfix as fallback)" })
            vim.keymap.set("n", "[d", function()
                if t.is_open() then
                    t.previous({ skip_groups = true, jump = true })
                elseif vim.diagnostic.get_prev_pos({ wrap = true}) then
                    vim.diagnostic.goto_prev({ wrap = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok and err ~= noErr then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end, { desc = "Trouble prev item (quickfix as fallback)" })
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
