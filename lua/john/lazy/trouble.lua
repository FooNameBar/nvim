return {
    "folke/trouble.nvim",
    opts = { use_diagnostics_signs = true },
    config = function()
        require("trouble").setup()
        -- note: diagnostics are not exclusive to lsp servers
        -- so these can be global keybindings
        vim.keymap.set("n", "<leader>vd", function()
            require("trouble").toggle()
        end, { desc = "Trouble view diagnostics"})
        vim.keymap.set("n", "[d",function()
            require("trouble").next({ skip_groups = true, jump = true })
        end, { desc = "Trouble next item in diagnostics"})
        vim.keymap.set("n", "]d",function()
            require("trouble").previous({ skip_groups = true, jump = true })
        end, { desc = "Trouble prev item in diagnostics"})
    end,
}
