return {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
        require('persistence').setup({
            dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),     -- directory where session files are saved
            options = { "buffers", "curdir", "help", "tabpages", "winsize" }, -- sessionoptions used for saving
            pre_save = nil,                                                   -- a function to call before saving the session
            save_empty = false,                                               -- don't save if there are no open file buffers
        })
        -- restore the session for the current directory
        vim.api.nvim_set_keymap("n", "<leader>ld", "<cmd>lua require('persistence').load()<cr>", { desc = "Persistence load session for current directory" })
        -- restore the last session
        vim.api.nvim_set_keymap("n", "<leader>ls", "<cmd>lua require('persistence').load({ last = true })<cr>", { desc = "Persistence load last session" })
        -- stop Persistence => session won't be saved on exit
        vim.api.nvim_set_keymap("n", "<leader>le", "<cmd>lua require('persistence').stop()<cr>", { desc = "Persistence do not save session" })
    end,
}
