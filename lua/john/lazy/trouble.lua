return {
    "folke/trouble.nvim",
    opts = { use_diagnostics_signs = true },
    config = function()
        require("trouble").setup()
        -- note: diagnostics are not exclusive to lsp servers
        -- so these can be global keybindings
        vim.keymap.set("n", "<leader>vd", function()
            require("trouble").toggle()
        end)
        vim.keymap.set("n", "[d",function()
            require("trouble").next({ skip_groups = true, jump = true })
        end)
        vim.keymap.set("n", "]d",function()
            require("trouble").previous({ skip_groups = true, jump = true })
        end)
    end,
}
