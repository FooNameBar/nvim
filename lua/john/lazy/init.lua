return {
    {
        "ThePrimeagen/vim-be-good",
        commit = "4fa57b7",
    },

    {
        "luckasRanarison/tailwind-tools.nvim",
        event = {"BufReadPre", "BufNewFile" },
        ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "astro", "vue", "svelte" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {}
    },
}
