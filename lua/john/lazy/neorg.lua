return {
    "nvim-neorg/neorg",
    event = "VeryLazy",
    build = ":Neorg sync-parsers",
    dependecies = { "nvim-lua/plenary.nvim" },
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
}
