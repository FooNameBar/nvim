-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use('junegunn/fzf')

    use('folke/tokyonight.nvim')

    use({
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
    })

    use('nvim-treesitter/playground')

    use('theprimeagen/harpoon')

    use('mbbill/undotree')

    use('tpope/vim-fugitive')

    use('ThePrimeagen/vim-be-good')

    use { "akinsho/toggleterm.nvim", tag = '*' }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use({
        'kylechui/nvim-surround',
        tag = "*",
        config = function()
            require('nvim-surround').setup()
        end
    })

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        'laytan/tailwind-sorter.nvim',
        requires = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        config = function() require('tailwind-sorter').setup() end,
        run = 'cd formatter && npm i && npm run build',
    }

    use('nvim-treesitter/nvim-treesitter-context')

    use('elentok/format-on-save.nvim')

    use {
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
end)
