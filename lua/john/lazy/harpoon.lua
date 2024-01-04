return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
        {
            "<leader>a",
            function()
                require("harpoon"):list():append()
            end,
            desc = "Add current file to list",
        },
        {
            "<C-e>",
            function()
                local h = require("harpoon")
                h.ui:toggle_quick_menu(h:list())
            end,
            desc = "Show list",
        },
        {
            "<C-h>",
            function()
                require("harpoon"):list():select(1)
            end,
            desc = "Go to first mark",
        },
        {
            "<C-j>",
            function()
                require("harpoon"):list():select(2)
            end,
            desc = "Go to second mark",
        },
        {
            "<C-k>",
            function()
                require("harpoon"):list():select(3)
            end,
            desc = "Go to third mark",
        },
        {
            "<C-l>",
            function()
                require("harpoon"):list():select(4)
            end,
            desc = "Go to fourth mark",
        },
        {
            "<leader>hn",
            function()
                require("harpoon"):list():next()
            end,
            desc = "Go to next mark",
        },
        {
            "<leader>hp",
            function()
                require("harpoon"):list():prev()
            end,
            desc = "Go to previous mark",
        },
    },
}
