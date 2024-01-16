return {
    "ThePrimeagen/vim-be-good",

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {}, -- required
    },

    {
        'laytan/tailwind-sorter.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        build = 'cd formatter && npm i && npm run build',
        config = true,
    },
}
