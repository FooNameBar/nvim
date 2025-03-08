return {
    {
        "ThePrimeagen/vim-be-good",
        commit = "4fa57b7",
    },

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
