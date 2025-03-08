return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup {
                columns = { "icon" },
                keymaps = {
                    ["<C-h>"] = false,
                    ["<C-s>"] = false,
                    ["<M-h"] = "actions.select_split",
                },
                view_options = {
                    show_hidden = true,
                },
            }

            -- Open parent directory in current window
            vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
        end,
    },
}
