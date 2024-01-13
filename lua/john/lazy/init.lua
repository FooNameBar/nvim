return {
    { "folke/lazy.nvim", version = "*" },
--    { "LazyVim/LazyVim", priority = 10000, lazy = false, config = true, version = "*" },

    -- Misc --

    "ThePrimeagen/vim-be-good",

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },

    {
        'laytan/tailwind-sorter.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        build = 'cd formatter && npm i && npm run build',
        config = true,
    },
}
