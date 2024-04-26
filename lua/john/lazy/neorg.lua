return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- We'd like this plugiun to load first out of the rest
        config = true,   -- This automatically runs 'require("luarocks-nvim").setup()'
    },
    {
        "nvim-neorg/neorg",
        dependecies = { "luarocks.nvim" },
        event = "VeryLazy",
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
}
