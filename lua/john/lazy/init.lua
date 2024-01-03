return {
    { "folke/lazy.nvim", version = "*" },
    { "LazyVim/LazyVim", priority = 10000, lazy = false, config = true, version = "*" },

    -- Misc --

    "ThePrimeagen/vim-be-good",

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    },

    {
        'laytan/tailwind-sorter.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        build = 'cd formatter && npm i && npm run build',
        config = true,
    }

    --[[
    {
        "nvim-neorg/neorg",
        ft = "norg",
        cmd = "Neorg",
        after = { "nvim-treesitter", "telescope.nvim" },
        run = ":Neorg sync-parsers",
        tag = "*",
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {
                        config = {
                            folds = false,
                        }
                    },
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/notes/",
                                projects = "~/notes/projects",
                                personal = "~/notes/personal",
                                examples = "~/notes/examples",
                            },
                            default_workspace = "notes",
                        },
                    },
                    ["core.qol.toc"] = {
                        config = {
                            close_after_use = true
                        },
                    },
                    ["core.summary"] = {},
                },
            }
        end,
        requires = "nvim-lua/plenary.nvim",
    }
    ]]--
}
