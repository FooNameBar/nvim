return {
    "ThePrimeagen/vim-be-good",

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {}, -- required
    },

    {
        "luckasRanarison/tailwind-tools.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {}
    },
}
